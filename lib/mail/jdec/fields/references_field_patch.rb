module Mail
  module Jdec
    module ReferencesFieldPatch
      def initialize(value = nil, charset = 'utf-8')
        if Jdec.enabled?
          if value.is_a?(String)
            value = value.gsub(/>\s*,\s*</, ">\r\n <")
          end
        end
        super
      end
    end
  end
end

unless Mail::ReferencesField.included_modules.include?(Mail::Jdec::ReferencesFieldPatch)
  Mail::ReferencesField.prepend Mail::Jdec::ReferencesFieldPatch
end
