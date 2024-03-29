# frozen_string_literal: true

module Mail
  module Jdec
    class Detector
      class << self
        def detect(text)
          return if text.nil?

          detected = CharlockHolmes::EncodingDetector.detect(text)
          detected if trusty?(detected) && find_encoding(detected)
        end

        private
    
        def find_encoding(detected)
          Encoding.find(detected[:encoding])
        rescue
          nil
        end

        def trusty?(detected)
          detected.key?(:type) &&
            detected.key?(:encoding) &&
            detected[:confidence].to_i >= Jdec.config.autodetect_confidence &&
            !Jdec.config.autodetect_skip_charsets.include?(detected[:encoding].downcase)
        end
      end
    end
  end
end
