require 'spec_helper'
require_relative '../../support/store_examples'

describe AvetmissData::Stores::V8::Client do
  describe 'NAT File' do
    specify { expect(described_class.file_name).not_to be_blank }
    specify { expect(described_class.file_name).to eq('NAT00080') }
  end

  describe 'v8 NAT00080 record' do
    let!(:line) { File.open(file_path).first }
    subject { described_class.from_line(line) }

    context 'when the record is valid' do
      context 'and has no extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00080.txt' }

        specify { expect(subject).not_to be_blank }
        specify { expect(subject.client_identifier).to eq('12345') }
        specify { expect(subject.name_for_encryption).to eq('Franklin, Mount') }
        specify { expect(subject.highest_school_level_completed).to eq('09') }
        specify { expect(subject.gender).to eq('M') }
        specify { expect(subject.date_of_birth).to eq('02091964') }
        specify { expect(subject.address_postcode).to eq('2850') }
        specify { expect(subject.indigenous_status_identifier).to eq('2') }
        specify { expect(subject.main_language_not_english).to eq('1201') }
        specify { expect(subject.labour_force_status_identifier).to eq('03') }
        specify { expect(subject.country_identifier).to eq('0012') }
        specify { expect(subject.disability_flag).to eq('Y') }
        specify { expect(subject.prior_education_achievement_flag).to eq('Y') }
        specify { expect(subject.at_school_flag).to eq('Y') }
        specify { expect(subject.address_suburb_locality_or_town).to eq('Aarons Pass') }
        specify { expect(subject.unique_student_identifier).to eq('123456') }
        specify { expect(subject.address_state_identifier).to eq('08') }
        specify { expect(subject.address_building).to eq('Headquarters') }
        specify { expect(subject.address_unit).to eq('1') }
        specify { expect(subject.address_street_number).to eq('2200') }
        specify { expect(subject.address_street_name).to eq('Mission College Blvd') }
        specify { expect(subject.survey_contact_status).to eq('A') }
        specify { expect(subject.extras).to be_blank }
      end

      context 'and has extra fields' do
        let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00080_extrafields.txt' }
        specify { expect(subject.extras).to eq('Extra Fields') }
      end
    end
    it_behaves_like :store_processing_invalid_file
  end
end
