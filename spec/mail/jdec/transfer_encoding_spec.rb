describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'invalid transfer encoding' do
    it 'returns raw source for unknown transfer encoding' do
      mail = Mail.read("spec/fixtures/transfer_encoding/unknown_transfer_encoding.eml")
      expect(mail.attachments.first.decoded).to_not eq(nil)
    end
  end
end
