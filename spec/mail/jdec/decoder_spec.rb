describe Mail::Jdec::Decoder do
  before do
    Mail::Jdec.enable!
  end

  it 'decodes' do
    value = Mail::Jdec::Decoder.decode_if_needed("差出人".encode('iso-2022-jp'))
    expect(value).to include("差出人")
  end

  it 'skips to decode' do
    value = Mail::Jdec::Decoder.decode_if_needed({})
    expect(value).to include({})
  end
end
