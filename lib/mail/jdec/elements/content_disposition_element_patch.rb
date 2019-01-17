module Mail
  module Jdec
    module ContentDispositionElementPatch
      def initialize(string)
        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          value = Jdec::Decoder.force_utf8(string)
          if (matched = value.match(/^\s*attachment\s*;\s*(.+)/im))
            @disposition_type = 'attachment'
            @parameters = [{ filename: matched[1].gsub(/(\r\n|\r|\n)\s/, '') }]
          else
            raise e
          end
        else
          raise e
        end
      end
    end
  end
end

unless Mail::ContentDispositionElement.included_modules.include?(Mail::Jdec::ContentDispositionElementPatch)
  Mail::ContentDispositionElement.prepend Mail::Jdec::ContentDispositionElementPatch
end
