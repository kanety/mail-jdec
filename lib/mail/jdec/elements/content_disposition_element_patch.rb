module Mail
  module Jdec
    module ContentDispositionElementPatch
      def initialize(string)
        if Jdec.enabled?
          # Remove extra trailing semicolon
          string = string.gsub(/;+$/, '')
          # Handles filename=test
          string = string.gsub(/filename\s*=\s*([^"]+?)\s*(;|$)/im) { %Q|filename="#{$1}"#{$2}| }
          # Handles filename=""test""
          string = string.gsub(/filename\s*=\s*"+([^"]+?)"+\s*(;|$)/im) { %Q|filename="#{$1}"#{$2}| }
        end

        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          @disposition_type = 'attachment'
          @parameters = ['filename' => Jdec::Decoder.force_utf8(string)]
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
