require 'spec_helper'

describe AvetmissData::Client do
  context 'imports the NAT00080 file' do

    context 'NAT File' do
      specify { expect(AvetmissData::Client.file).not_to be_blank }
      specify { expect(AvetmissData::Client.file).to eq('NAT00080') }
    end

    context 'NAT Record Parse' do
      let!(:row) { File.open('spec/fixtures/nat_files/NAT00080.txt').first }
      subject { AvetmissData::Client.parse(row) }

      specify { expect(subject).not_to be_blank }
      specify { expect(subject[:client_identifier]).to eq('12345') }
      specify { expect(subject[:name_for_encryption]).to eq('Franklin, Mount') }
      specify { expect(subject[:highest_school_level_completed]).to eq('09') }
      specify { expect(subject[:highest_school_level_completed_year]).to eq('1990') }
      specify { expect(subject[:sex]).to eq('M') }
      specify { expect(subject[:date_of_birth]).to eq('02091964') }
      specify { expect(subject[:post_code]).to eq('2850') }
      specify { expect(subject[:indigenous_status_identifier]).to eq('2') }
      specify { expect(subject[:main_language_not_english]).to eq('1201') }
      specify { expect(subject[:labour_force_status_identifier]).to eq('03') }
      specify { expect(subject[:country_identifier]).to eq('0012') }
      specify { expect(subject[:disability_flag]).to eq('Y') }
      specify { expect(subject[:prior_education_achievement_flag]).to eq('Y') }
      specify { expect(subject[:at_school_flag]).to eq('Y') }
      specify { expect(subject[:english_proficiency_identifier]).to be_blank }
      specify { expect(subject[:address_location]).to eq('Aarons Pass') }
      specify { expect(subject[:extras]).to be_blank }
    end
  end
end
