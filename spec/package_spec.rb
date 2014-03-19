require 'spec_helper'

describe AvetmissData::Package do
  let!(:package) { AvetmissData::Package.new }

  context '<<' do
    let!(:enrolment_store) { AvetmissData::Stores::Enrolment.new }
    before { package.enrolment_stores << enrolment_store }
    specify { expect(enrolment_store.package).to eq(package) }
  end

  context 'create package' do
    before do
      package.enrolment_stores << AvetmissData::Stores::Enrolment.new(unit_competency_identifier: 'BSBRES401A',
                                                                      package: package)
    end

    specify { expect(package.enrolment_stores.length).to eq(1) }
    let!(:enrolment_store) { package.enrolment_stores.first }
    specify { expect(enrolment_store.unit_competency_identifier).to eq('BSBRES401A') }

    specify { expect(package.enrolment_stores.first.package).to eq(package) }
  end

  context 'load package from zip' do
    before { package.from_zip_file('spec/fixtures/zip_files/valid.zip') }

=begin
    specify do
      expect(package.rto_stores.length).to eq(1)
      expect(package.rto_delivery_location_stores.length).to eq(1)
      expect(package.course_stores.length).to eq(1)
      expect(package.unit_of_competency_stores.length).to eq(1)
      expect(package.client_stores.length).to eq(32)
      expect(package.client_postal_detail_stores.length).to eq(5)
      expect(package.disability_stores.length).to eq(1)
      expect(package.achievement_stores.length).to eq(1)
      expect(package.enrolment_stores.length).to eq(5)
      expect(package.qual_completion_stores.length).to eq(1)
    end
=end
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

  context '#stores_list_for' do
    let(:client_store) { AvetmissData::Stores::Client.new }
    subject { package.store_list_for(client_store) }
    specify { expect(subject).to equal(package.client_stores) }
    specify { expect(subject).not_to equal(package.enrolment_stores) }
  end
end
