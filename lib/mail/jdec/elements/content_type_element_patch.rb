module Mail
  module Jdec
    module ContentTypeElementPatch
      def initialize(string)
        if Jdec.enabled?
          # Handles ; name=
          string = string.gsub(/^\s*;?\s*name=(.+)$/im) { "application/octet-stream; name=#{$1}" }
        end

        super
      end
    end
  end
end

unless Mail::ContentTypeElement.included_modules.include?(Mail::Jdec::ContentTypeElementPatch)
  Mail::ContentTypeElement.prepend Mail::Jdec::ContentTypeElementPatch
end
