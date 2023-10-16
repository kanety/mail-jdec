describe Mail::Jdec do
  before do
    Mail::Jdec.enable!
  end

  context 'invalid content type' do
    it 'removes extra trailing semicolon' do
      mail = Mail.read("spec/fixtures/content_type/content_type_trailing_semicolon.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'removes extra quotation' do
      mail = Mail.read("spec/fixtures/content_type/content_type_extra_quote.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'adds necessary quotation' do
      mail = Mail.read("spec/fixtures/content_type/content_type_wo_quote.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
    end

    it 'removes unnecessary spacing for charsets' do
      mail = Mail.read("spec/fixtures/content_type/content_type_charset_spacing.eml")
      expect(mail.mime_type).to eq("text/plain")
      expect(mail.charset).to eq("iso-2022-jp")
    end

    it 'adds unknown if no sub type provided' do
      mail = Mail.read("spec/fixtures/content_type/content_type_wo_sub_type.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
      expect(mail.parts[1].mime_type).to eq("application/unknown")
    end

    it 'adds application/octet-stream if no mime provided' do
      mail = Mail.read("spec/fixtures/content_type/content_type_wo_mime.eml")
      expect(mail.parts[1].filename).to eq("添付ファイル.dat")
      expect(mail.parts[1].mime_type).to eq("application/octet-stream")
      expect(mail.parts[2].filename).to eq("添付ファイル.dat")
      expect(mail.parts[2].mime_type).to eq("application/octet-stream")
    end

    it 'returns raw source as filename if unparsable' do
      mail = Mail.read("spec/fixtures/content_type/content_type_error.eml")
      expect(mail.parts[1].filename).to include("name=")
    end
  end
end
