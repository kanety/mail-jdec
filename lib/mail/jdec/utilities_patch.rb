# frozen_string_literal: true

module Mail
  module Jdec
    module UtilitiesPatch
      def pick_encoding(charset)
        if Jdec.enabled?
          Jdec.config.preferred_charsets.each do |from, to|
            if charset.to_s.downcase == from
              return Encoding.find(to)
            end
          end
        end
        super
      end

      def transcode_charset(str, from_encoding, to_encoding = Encoding::UTF_8)
        if Jdec.enabled?
          case from_encoding.to_s.downcase
          when 'unicode-1-1-utf-7'
            str = Decoder.decode_utf7(str).encode(to_encoding, undef: :replace, invalid: :replace)
          else
            str = super
          end
          if to_encoding.to_s.downcase == 'utf-8'
            str.gsub!(/^\x00+/, '')
            str.gsub!(/\x00+$/, '')
          end
          str
        else
          super
        end
      end
    end
  end
end

Mail::Utilities.singleton_class.prepend Mail::Jdec::UtilitiesPatch
