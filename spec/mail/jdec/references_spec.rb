describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  it 'handles references splitted by comma' do
    mail = Mail.read("spec/fixtures/references_splitted_comma.eml")
    expect(mail.references.size).to eq(2)
  end
end
