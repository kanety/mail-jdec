module Mail
  module Jdec
    module Ruby19Patch
      def pick_encoding(charset)
        if Jdec.enabled?
          Jdec.preferred_charsets.each do |from, to|
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
          str.strip! if to_encoding.to_s.downcase == 'utf-8'
          str
        else
          super
        end
      end
    end
  end
end

unless Mail::Ruby19.singleton_class.included_modules.include?(Mail::Jdec::Ruby19Patch)
  Mail::Ruby19.singleton_class.prepend Mail::Jdec::Ruby19Patch
end
