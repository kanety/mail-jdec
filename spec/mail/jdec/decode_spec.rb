describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'mail lacks Content-Type' do
    it 'decodes iso-2022-jp' do
      mail = Mail.read("spec/fixtures/iso-2022-jp.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail[:cc].decoded).to include("宛先CC")
      expect(mail[:bcc].decoded).to include("宛先BCC")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'decodes iso-2022-jp multipart' do
      mail = Mail.read("spec/fixtures/iso-2022-jp_multipart.eml")
  
      expect(mail.parts[0].decoded).to include("テストメールの本文")
      expect(mail.parts[1].filename).to include("添付ファイル")
    end

    it 'does not decode if disabled' do
      Mail::Jdec.disable
      mail = Mail.read("spec/fixtures/iso-2022-jp.eml")

      expect(mail[:from].decoded).not_to include("差出人")
      expect(mail[:to].decoded).not_to include("宛先")
      expect(mail[:cc].decoded).not_to include("宛先CC")
      expect(mail[:bcc].decoded).not_to include("宛先BCC")
      expect(mail.subject).not_to include("テストメールの件名")
      expect(mail.decoded).not_to include("テストメールの本文")
    end
  end

  context 'valid mails' do
    it 'decodes iso-2022-jp' do
      mail = Mail.read("spec/fixtures/valid/iso-2022-jp_multipart.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.parts[0].decoded).to include("テストメールの本文")
      expect(mail.parts[1].filename).to include("添付ファイル")
    end

    it 'decodes shift_jis' do
      mail = Mail.read("spec/fixtures/valid/shift_jis.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end
  end
end
