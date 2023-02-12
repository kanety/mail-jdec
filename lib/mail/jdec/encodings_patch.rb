# frozen_string_literal: true

module Mail
  module Jdec
    module EncodingsPatch
      def value_decode(str)
        if Jdec.enabled?
          Jdec::ValueDecoder.value_decode(str)
        else
          super
        end
      end
    end
  end
end

unless Mail::Encodings.singleton_class.included_modules.include?(Mail::Jdec::EncodingsPatch)
  Mail::Encodings.singleton_class.prepend Mail::Jdec::EncodingsPatch
end
