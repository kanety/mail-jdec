# frozen_string_literal: true

module Mail
  module Jdec
    module ContentTypeElementPatch
      def initialize(string)
        if Jdec.enabled?
          # Remove extra trailing semicolon
          string = string.gsub(/;+$/, '')
          # Remove unnecessary space
          string = string.gsub(/;\s*charset\s+=\s+/i, '; charset=')
          # Handles name=test
          string = string.gsub(/name\s*=\s*([^"]+?)\s*(;|$)/im) { %Q|name="#{$1}"#{$2}| }
          # Handles name=""test""
          string = string.gsub(/name\s*=\s*"+([^"]+?)"+\s*(;|$)/im) { %Q|name="#{$1}"#{$2}| }
          # Handles text; name=test
          string = string.gsub(/^\s*([^\/]+)\s*;\s*name\s*=\s*(.+)$/im) { "#{$1}/unknown; name=#{$2}" }
          # Handles ; name=test
          string = string.gsub(/^\s*;?\s*name\s*=\s*(.+)$/im) { "application/octet-stream; name=#{$1}" }
        end

        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          @main_type = 'application'
          @sub_type = 'octet-stream'
          @parameters = ['name' => Jdec::Decoder.force_utf8(string)]
        else
          raise e
        end
      end
    end
  end
end

unless Mail::ContentTypeElement.included_modules.include?(Mail::Jdec::ContentTypeElementPatch)
  Mail::ContentTypeElement.prepend Mail::Jdec::ContentTypeElementPatch
end
