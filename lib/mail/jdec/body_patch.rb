# frozen_string_literal: true

module Mail
  module Jdec
    module BodyPatch
      def decoded
        super
      rescue Mail::UnknownEncodingType => e
        if Jdec.enabled?
          Jdec::Decoder.force_utf8(raw_source)
        else
          raise e
        end
      end
    end
  end
end

unless Mail::Body.included_modules.include?(Mail::Jdec::BodyPatch)
  Mail::Body.prepend Mail::Jdec::BodyPatch
end
