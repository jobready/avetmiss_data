shared_examples :store_processing_invalid_file do
  context 'when the record is invalid' do
    let!(:file_path) { 'spec/fixtures/nat_files/v8/generic_invalid.txt' }

    specify { expect{ subject }.to_not raise_error }
    it 'creates a populated store' do
      expect(subject).not_to be_blank
    end
  end
end
