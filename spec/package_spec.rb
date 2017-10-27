require 'spec_helper'

describe AvetmissData::Package do
  let(:package) { AvetmissData::Package.new }

  describe 'initialize' do
    context 'when attributes provided' do
      context 'and version provided' do
        let(:package) { AvetmissData::Package.new(activity_year: 2014, version: '7.0') }

        it 'assigns provided attributes' do
          expect(package.activity_year).to eq(2014)
        end

        it 'assigns provided version' do
          expect(package.version).to eq('7.0')
        end
      end

      context 'and version omitted' do
        let(:package) { AvetmissData::Package.new(activity_year: 2014) }

        it 'assigns provided attributes' do
          expect(package.activity_year).to eq(2014)
        end

        it 'uses default version' do
          expect(package.version).to eq('8.0')
        end
      end
    end

    context 'when attributes omitted' do
      context 'and version provided' do
        let(:package) { AvetmissData::Package.new(version: '7.0') }

        it 'assigns provided version' do
          expect(package.version).to eq('7.0')
        end
      end

      context 'and version omitted' do
        let(:package) { AvetmissData::Package.new() }

        it 'uses default version' do
          expect(package.version).to eq('8.0')
        end
      end
    end
  end

  context '<<' do
    let!(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    before { package.enrolment_stores << enrolment_store }
    specify { expect(enrolment_store.package).to eq(package) }
  end

  context 'create package' do
    before do
      package.enrolment_stores << AvetmissData::Stores::V7::Enrolment.new(unit_competency_identifier: 'BSBRES401A',
                                                                      package: package)
    end

    specify { expect(package.enrolment_stores.length).to eq(1) }
    let!(:enrolment_store) { package.enrolment_stores.first }
    specify { expect(enrolment_store.unit_competency_identifier).to eq('BSBRES401A') }

    specify { expect(package.enrolment_stores.first.package).to eq(package) }
  end

  context 'create zip file' do
    let(:temp_file) { Tempfile.new('package') }
    let(:zip_file) { AvetmissData::ZipFile.new(temp_file.path) }
    let(:file_names) { zip_file.stores.keys }

    context 'in standard format' do
      let(:create_zip_file) do
        File.open(temp_file.path, 'wb:ASCII-8BIT') { |f| f << package.to_zip_file }
      end

      context 'for an unknown version' do
        let(:package) { AvetmissData::Package.new(version: '5.0') }
        let(:error_msg) { 'Unknown NAT Version: 5.0' }

        it 'raises an AvetmissData::Errors::UnknownVersionError' do
          expect{ create_zip_file }.
            to raise_error(AvetmissData::Errors::UnknownVersionError, error_msg)
        end
      end

      context 'for a known version' do
        before do
          create_zip_file
        end

        context 'for a v6 package' do
          let(:package) { AvetmissData::Package.new(version: '6.1') }

          it 'contains all standard files for RTO submission' do
            expect(file_names).to match_array(AvetmissData::Package::V6_V7_FILES_MAP.values)
          end
        end

        context 'for a v7 package' do
          let(:package) { AvetmissData::Package.new(version: '7.0') }

          it 'contains all standard files for RTO submission' do
            expect(file_names).to match_array(AvetmissData::Package::V6_V7_FILES_MAP.values)
          end
        end

        context 'for a v8 package' do
          let(:package) { AvetmissData::Package.new(version: '8.0') }

          it 'contains all standard files for RTO submission' do
            expect(file_names).to match_array(AvetmissData::Package::V8_FILES_MAP.values)
          end
        end
      end
    end

    context 'in aggregate format' do
      before do
        File.open(temp_file.path, 'wb:ASCII-8BIT') { |f| f << package.to_aggregate_zip_file }
      end

      context 'for a v7 package' do
        it 'contains each store type' do
          expect(file_names.count).to eq(11)
        end
        it 'contains standard files plus submission file for STA aggregate submission' do
          expect(file_names).to match_array(AvetmissData::Package::V6_V7_AGGREGATE_FILES_MAP.values)
        end
      end
    end
  end

  context 'load package from zip' do
    let(:package) { AvetmissData::Package.from_zip_file(zip_file) }

    context '8.0' do
      let(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/v8/valid.zip', '8.0') }

      specify { expect(package.rto_stores.length).to eq(1) }
      specify { expect(package.rto_delivery_location_stores.length).to eq(2) }
      specify { expect(package.course_stores.length).to eq(1) }
      specify { expect(package.unit_of_competency_stores.length).to eq(1) }
      specify { expect(package.client_stores.length).to eq(1) }
      specify { expect(package.client_postal_detail_stores.length).to eq(1) }
      specify { expect(package.disability_stores.length).to eq(2) }
      specify { expect(package.achievement_stores.length).to eq(8) }
      specify { expect(package.enrolment_stores.length).to eq(1) }
      specify { expect(package.qual_completion_stores.length).to eq(1) }

      let!(:rto_store) { package.rto_stores.first }
      specify { expect(rto_store.training_organisation_identifier).to eq('12345') }
      let!(:enrolment_store) { package.enrolment_stores.first }
      specify { expect(enrolment_store.unit_competency_identifier).to eq('BSBCUS402A') }

      specify { expect(package.client_stores.first.package).to eq(package) }
    end

    context '7.0' do
      let(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/v7/valid.zip', '7.0') }

      specify { expect(package.submission_stores.length).to eq(1) }
      specify { expect(package.rto_stores.length).to eq(1) }
      specify { expect(package.rto_delivery_location_stores.length).to eq(1) }
      specify { expect(package.course_stores.length).to eq(1) }
      specify { expect(package.unit_of_competency_stores.length).to eq(1) }
      specify { expect(package.client_stores.length).to eq(32) }
      specify { expect(package.client_postal_detail_stores.length).to eq(5) }
      specify { expect(package.disability_stores.length).to eq(1) }
      specify { expect(package.achievement_stores.length).to eq(1) }
      specify { expect(package.enrolment_stores.length).to eq(5) }
      specify { expect(package.qual_completion_stores.length).to eq(1) }

      let!(:rto_store) { package.rto_stores.first }
      specify { expect(rto_store.training_organisation_identifier).to eq('0101') }
      let!(:enrolment_store) { package.enrolment_stores.first }
      specify { expect(enrolment_store.unit_competency_identifier).to eq('BSBRES401A') }

      specify { expect(package.client_stores.first.package).to eq(package) }
    end

    context '6.1' do
      let(:zip_file) { AvetmissData::ZipFile.new('spec/fixtures/zip_files/v6/valid.zip', '6.1') }

      specify { expect(package.rto_stores.length).to eq(1) }
      specify { expect(package.rto_delivery_location_stores.length).to eq(1) }
      specify { expect(package.course_stores.length).to eq(1) }
      specify { expect(package.unit_of_competency_stores.length).to eq(1) }
      specify { expect(package.client_stores.length).to eq(32) }
      specify { expect(package.client_postal_detail_stores.length).to eq(5) }
      specify { expect(package.disability_stores.length).to eq(1) }
      specify { expect(package.achievement_stores.length).to eq(1) }
      specify { expect(package.enrolment_stores.length).to eq(5) }
      specify { expect(package.qual_completion_stores.length).to eq(1) }

      let!(:rto_store) { package.rto_stores.first }
      specify { expect(rto_store.training_organisation_identifier).to eq('0101') }
      let!(:enrolment_store) { package.enrolment_stores.first }
      specify { expect(enrolment_store.unit_competency_identifier).to eq('BSBRES401A') }

      specify { expect(package.client_stores.first.package).to eq(package) }
    end
  end

  context '#stores_list_for' do
    let(:client_store) { AvetmissData::Stores::V7::Client.new }
    subject { package.store_list_for(client_store) }
    specify { expect(subject).to equal(package.client_stores) }
    specify { expect(subject).not_to equal(package.enrolment_stores) }
  end

  context '#[]' do
    let!(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    before { package.enrolment_stores << enrolment_store }
    specify { expect(package[:enrolment_stores]).to include(enrolment_store) }
  end

  context '#[]=' do
    let!(:enrolment_store) { AvetmissData::Stores::V7::Enrolment.new }
    before { package[:enrolment_stores] = [enrolment_store] }
    specify { expect(package.enrolment_stores).to include(enrolment_store) }
  end

  context '#each_store' do
    let(:client_store) { AvetmissData::Stores::V7::Client.new }
    let(:rto_store) { AvetmissData::Stores::V7::Rto.new }
    before do
      package.client_stores << client_store
      package.rto_stores << rto_store
    end

    specify { expect { |b| package.each_store(&b) }.to yield_successive_args(rto_store, client_store) }
  end

  context '#unit_of_competency_stores=' do
    before { package.unit_of_competency_stores = [] }
    specify { expect(package.unit_of_competency_stores).to be_a AvetmissData::StoresList }
  end

  describe '#files_map' do
    subject { package.files_map }

    let(:package) { AvetmissData::Package.new(version: version) }

    context 'for V8 package' do
      let(:version) { '8.0' }

      specify do
        expect(subject).to eq(described_class::V8_FILES_MAP)
      end
    end

    context 'for V7 package' do
      let(:version) { '7.0' }

      specify do
        expect(subject).to eq(described_class::V6_V7_FILES_MAP)
      end
    end

    context 'for V6.1 package' do
      let(:version) { '6.1' }

      specify do
        expect(subject).to eq(described_class::V6_V7_FILES_MAP)
      end
    end
  end
end
