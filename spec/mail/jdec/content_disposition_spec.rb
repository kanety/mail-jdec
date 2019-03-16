describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'invalid content disposition' do
    it 'removes extra trailing semicolon' do
      mail = Mail.read("spec/fixtures/content_disposition/content_disposition_trailing_semicolon.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'removes extra quotation' do
      mail = Mail.read("spec/fixtures/content_disposition/content_disposition_extra_quote.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'adds necessary quotation' do
      mail = Mail.read("spec/fixtures/content_disposition/content_disposition_wo_quote.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'returns raw source as filename if unparsable' do
      mail = Mail.read("spec/fixtures/content_disposition/content_disposition_error.eml")
      expect(mail.parts[1].attachment?).to be_truthy
      expect(mail.parts[1].filename).to include("filename=")
    end
  end
end
