# frozen_string_literal: true

module Mail
  module Jdec
    module MessageIdsElementPatch
      private

      def parse(string)
        if Jdec.enabled? && string.is_a?(String)
          string = string.gsub(/\t/, ' ')
        end
        super
      end
    end
  end
end

unless Mail::MessageIdsElement.included_modules.include?(Mail::Jdec::MessageIdsElementPatch)
  Mail::MessageIdsElement.prepend Mail::Jdec::MessageIdsElementPatch
end
