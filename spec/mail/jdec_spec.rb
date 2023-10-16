describe Mail::Jdec do
  it 'has a version number' do
    expect(Mail::Jdec::VERSION).not_to be nil
  end

  context 'config' do
    around(:example) do |example|
      val = Mail::Jdec.config.autodetect_confidence
      example.run
      Mail::Jdec.config.autodetect_confidence = val
    end

    it 'sets global config via configure' do
      Mail::Jdec.configure do |config|
        config.autodetect_confidence = 100
      end
      expect(Mail::Jdec.config.autodetect_confidence).to eq(100)
    end

    it 'sets current config via block' do
      Mail::Jdec.with_config(autodetect_confidence: 100) do
        expect(Mail::Jdec.config.autodetect_confidence).to eq(100)
      end
    end
  end
end
