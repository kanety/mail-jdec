RSpec.describe Mail::Jdec::FieldListPatch do
  before do
    Mail::Jdec.enable!
  end

  let(:mail) do
    Mail.new(charset: 'utf-8') do
      body 'test'
    end
  end

  it 'uses rfc2231 format' do
    Mail::Jdec.with_config(keep_field_order: true) do
      mail.header['Received'] = 'Received 1'
      mail.header['Scanned'] = 'Scanned 1'
      mail.header['Received'] = 'Received 2'
      mail.header['Scanned'] = 'Scanned 2'
      expect(mail.header.fields.map(&:name)).to eq(['Received', 'Scanned', 'Received', 'Scanned'])
      expect(mail.header.fields.map(&:value)).to eq(['Received 1', 'Scanned 1', 'Received 2', 'Scanned 2'])
    end
  end
end
