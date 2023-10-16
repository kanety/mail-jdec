# frozen_string_literal: true

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
          # Escape tspecial chars in RFC2231 filename
          string = string.gsub(/filename\*(\d*)(\*?)\s*=\s*(\S+?)'(\S*)'(\S+)(;|$)/i) { %Q|filename*#{$1}#{$2}=#{$3}'#{$4}'#{Escaper.escape($5)}#{$6}| }
          string = string.gsub(/filename\*(\d*)(\*?)\s*=\s*(\S+)(;|$)/i) { %Q|filename*#{$1}#{$2}=#{Escaper.escape($3)}#{$4}| }
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

    module Escaper
      def self.escape(str)
        require 'cgi'
        str.gsub(/[#{Regexp.escape(%Q|()<>@,;:\\"/[]?=|)}]/) do |c|
          CGI.escape(c)
        end
      end
    end
  end
end

Mail::ContentDispositionElement.prepend Mail::Jdec::ContentDispositionElementPatch
