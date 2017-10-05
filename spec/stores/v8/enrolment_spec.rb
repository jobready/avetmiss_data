# TODO: Update specs/fixtures to standard approach - 1 fixture file with 1 line + additional data we ignore

require 'spec_helper'

describe AvetmissData::Stores::V8::Enrolment do
  context 'NAT File' do
    specify { expect(AvetmissData::Stores::V8::Enrolment.file_name).not_to be_blank }
    specify { expect(AvetmissData::Stores::V8::Enrolment.file_name).to eq('NAT00120') }
  end

  context 'v8 NAT00120 file' do
    let!(:line) { File.open(file_path).first }
    subject { AvetmissData::Stores::V8::Enrolment.from_line(line) }

    context 'when the record is valid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/NAT00120.txt' }
      specify { expect(subject).not_to be_blank }
      specify { expect(subject.training_organisation_identifier).to eq('1112') }
      specify { expect(subject.delivery_location_identifier).to eq('4712') }
      specify { expect(subject.client_identifier).to eq('12345') }
      specify { expect(subject.unit_competency_identifier).to eq('BSBCUS402A') }
      specify { expect(subject.qualification_identifier).to eq('UTE31206') }
      specify { expect(subject.enrolment_activity_start_date).to eq('16042013') }
      specify { expect(subject.enrolment_activity_end_date).to eq('16082015') }
      specify { expect(subject.delivery_mode_identifier).to eq('303') }
      specify { expect(subject.national_outcome_identifier).to eq('70') }
      specify { expect(subject.national_funding_source).to eq('13') }
      specify { expect(subject.commencing_course_identifier).to eq('4') }
      specify { expect(subject.new_apprenticeships_training_contract_identifier).to eq('bc123') }
      specify { expect(subject.new_apprenticeships_client_identifier).to eq('bc321') }
      specify { expect(subject.study_reason_identifier).to eq('@@') }
      specify { expect(subject.vet_in_school_flag).to eq('N') }
      specify { expect(subject.specific_funding_identifier).to eq('9898121266') }
      specify { expect(subject.school_type_identifier).to eq('AB') }
      specify { expect(subject.training_organisation_outcome_identifier).to eq('70') }
      specify { expect(subject.state_training_authority_funding_source).to eq('0') }
      specify { expect(subject.client_tuition_fee).to eq('12345') }
      specify { expect(subject.exemption_type_identifier).to eq('19') }
      specify { expect(subject.purchasing_contract_identifier).to eq('123456781234') }
      specify { expect(subject.purchasing_contract_schedule_identifier).to eq('123') }
      specify { expect(subject.hours_attended).to eq('1234') }
      specify { expect(subject.associated_course_identifier).to eq('1234567891') }
      specify { expect(subject.scheduled_hours).to eq('0101') }
      specify { expect(subject.predominant_delivery_mode).to eq('A') }
      specify { expect(subject.extras).to eq('extra data that we ignore') }
    end

    # REVISE: Is this a useful test? I guess it confirms that the store builds without errors, regardless of the parsed data.
    #         If useful, I should create a shared example and use across all stores
    context 'when the record is invalid' do
      let(:file_path) { 'spec/fixtures/nat_files/v8/generic_invalid.txt' }
      specify { expect(subject).not_to be_blank }
    end
  end
end
