describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'invalid address' do
    it 'returns empty list for empty address' do
      mail = Mail.read("spec/fixtures/address/empty_address.eml")
      expect(mail.header[:from].addrs.size).to eq(0)
    end
  end
end
