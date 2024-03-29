describe Mail::Jdec do
  before do
    Mail::Jdec.enable!
  end

  context 'no charset' do
    it 'decodes iso-2022-jp' do
      mail = Mail.read("spec/fixtures/decode/iso-2022-jp.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail[:cc].decoded).to include("宛先CC")
      expect(mail[:bcc].decoded).to include("宛先BCC")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'decodes iso-2022-jp multipart' do
      mail = Mail.read("spec/fixtures/decode/iso-2022-jp_multipart.eml")

      expect(mail.parts[0].decoded).to include("テストメールの本文")
      expect(mail.parts[1].filename).to include("添付ファイル")
    end

    it 'decodes utf-8' do
      mail = Mail.read("spec/fixtures/decode/utf-8.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail[:cc].decoded).to include("宛先CC")
      expect(mail[:bcc].decoded).to include("宛先BCC")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'does not decode if disabled' do
      Mail::Jdec.disable!
      mail = Mail.read("spec/fixtures/decode/iso-2022-jp.eml")

      expect(mail[:from].decoded).not_to include("差出人")
      expect(mail[:to].decoded).not_to include("宛先")
      expect(mail[:cc].decoded).not_to include("宛先CC")
      expect(mail[:bcc].decoded).not_to include("宛先BCC")
      expect(mail.subject).not_to include("テストメールの件名")
      expect(mail.decoded).not_to include("テストメールの本文")
    end
  end

  context 'known charset' do
    it 'decodes iso-2022-jp' do
      mail = Mail.read("spec/fixtures/decode/valid/iso-2022-jp_multipart.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.parts[0].decoded).to include("テストメールの本文")
      expect(mail.parts[1].filename).to include("添付ファイル")
    end

    it 'decodes shift_jis' do
      mail = Mail.read("spec/fixtures/decode/valid/shift_jis.eml")

      expect(mail[:from].decoded).to include("差出人")
      expect(mail[:to].decoded).to include("宛先")
      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'does not decode if content type is not text' do
      mail = Mail.read("spec/fixtures/decode/valid/attachment_rfc822.eml")
      expect(mail.parts[1].decoded).not_to include("添付メールの本文")
    end
  end

  context 'preferred encoding' do
    it 'decodes with preferred encoding' do
      mail = Mail.read("spec/fixtures/decode/iso-2022-jp_multipart_windows.eml")

      chars = "①②③ｱｲｳｴｵ"
      expect(mail.subject).to include(chars)
      expect(mail.parts[0].decoded).to include(chars)
      expect(mail.parts[1].filename).to include(chars)
    end
  end

  context 'unicode-1-1-utf-7' do
    it 'decodes unicode-1-1-utf-7' do
      mail = Mail.read("spec/fixtures/decode/unicode-1-1-utf-7.eml")

      expect(mail.subject).to include("テストメールの件名")
      expect(mail.decoded).to include("テストメールの本文")
    end
  end

  context 'ascii-8bit' do
    it 'decodes undetected charset as utf-8' do
      mail = Mail.read("spec/fixtures/decode/undetected_charset.eml")

      expect(mail.from.first).to include('test')
      expect(mail.subject).to include('test subject')
      expect(mail.decoded).to include('test body')
    end

    it 'decodes ascii-8bit as utf-8' do
      mail = Mail.read("spec/fixtures/decode/valid/ascii-8bit.eml")

      expect(mail.decoded.encoding).to eq(Encoding::UTF_8)
      expect(mail.decoded).to include('test body')
    end
  end

  context 'mime types' do
    it 'decodes text/plain' do
      mail = Mail.read("spec/fixtures/decode/mime_types/text_plain.eml")

      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'decodes text/html' do
      mail = Mail.read("spec/fixtures/decode/mime_types/text_html.eml")

      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'decodes message/delivery_status' do
      mail = Mail.read("spec/fixtures/decode/mime_types/message_delivery_status.eml")

      expect(mail.decoded).to include("テストメールの本文")
    end

    it 'does not decode message/rfc822' do
      mail = Mail.read("spec/fixtures/decode/mime_types/message_rfc822.eml")

      expect(mail.decoded).not_to include("テストメールの本文")
    end
  end
end
