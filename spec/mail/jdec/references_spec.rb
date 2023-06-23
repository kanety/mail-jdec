describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'invalid references' do
    it 'handles references splitted by comma' do
      mail = Mail.read("spec/fixtures/references/references_splitted_comma.eml")
      expect(mail.references.size).to eq(2)
    end

    it 'removes tab characters in references header' do
      mail = Mail.read("spec/fixtures/references/tab_char.eml")
      expect(mail.references.size).to eq(2)
    end
  end
end
