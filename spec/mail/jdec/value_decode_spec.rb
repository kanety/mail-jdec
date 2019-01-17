describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  it 'decodes b value splitted in bytes' do
    mail = Mail.read("spec/fixtures/iso-2022-jp_splitted_b_value.eml")
    expect(mail.subject).to include("テストメールの件名")
  end

  it 'decodes q value splitted in bytes' do
    mail = Mail.read("spec/fixtures/iso-2022-jp_splitted_q_value.eml")
    expect(mail.subject).to include("テストメールの件名")
  end
end
