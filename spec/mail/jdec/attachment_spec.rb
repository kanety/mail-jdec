describe Mail::Jdec do
  it 'sanitizes Content-Disposition field' do
    mail = Mail.read("spec/fixtures/attachment_content_disposition_break.eml")
    expect(mail.parts[1].attachment?).to be_truthy
    expect(mail.parts[1].filename).to include("iso-2022-jp")
  end

  it 'sanitizes Content-Type field' do
    mail = Mail.read("spec/fixtures/attachment_content_type_break.eml")
    expect(mail.parts[1].attachment?).to be_truthy
    expect(mail.parts[1].filename).to include("添付ファイル")
  end
end
