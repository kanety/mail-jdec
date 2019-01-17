describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  it 'uses preferred encodings' do
    mail = Mail.read("spec/fixtures/iso-2022-jp_multipart_windows.eml")

    chars = "①②③ｱｲｳｴｵ"
    expect(mail.subject).to include(chars)
    expect(mail.parts[0].decoded).to include(chars)
    expect(mail.parts[1].filename).to include(chars)
  end
end
