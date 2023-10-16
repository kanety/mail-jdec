describe Mail::Jdec do
  before do
    Mail::Jdec.enable!
  end

  context 'decode after encode' do
    it 'decode subject' do
      encoded = Mail::Field.new('subject', "test =?UTF-8?B?5Lu25ZCN?=").encoded
      decoded = Mail::Field.new('subject', encoded).decoded
      expect(decoded).to include("test 件名")
    end
  end
end
