describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  context 'invalid date' do
    it 'returns nil for unparsable date' do
      mail = Mail.read("spec/fixtures/date/invalid_date.eml")
      expect(mail.date).to eq(nil)
    end

    it 'decodes date having out of range hour' do
      mail = Mail.read("spec/fixtures/date/out_of_range_hour.eml")
      expect(mail.date.strftime('%Y/%m/%d %H:%M:%S')).to eq('2015/01/02 02:00:00')
    end
  end
end
