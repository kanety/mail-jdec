describe Mail::Jdec do
  before do
    Mail::Jdec.enable
  end

  it "sorts parameters by counter" do
    hash = Mail::ParameterHash.new
    hash.merge!({'value*0*' => "us-ascii'en'%61",
                 'value*1*' => "%62",
                 'value*2*' => "%63",
                 'value*3*' => "%64",
                 'value*4*' => "%65",
                 'value*5*' => "%66",
                 'value*6*' => "%67",
                 'value*7*' => "%68",
                 'value*8*' => "%69",
                 'value*9*' => "%6A",
                 'value*10*' => "%2E",
                 'value*11*' => "%74",
                 'value*12*' => "%78",
                 'value*13' => "%74",})
    expect(hash['value']).to eq 'abcdefghij.txt'
  end
end
