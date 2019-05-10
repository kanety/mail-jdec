module Mail
  module Jdec
    class Decoder
      class << self
        def decode_if_needed(text)
          return text if text.nil? || text.encoding == Encoding::UTF_8

          detected = Detector.detect(text)
          if detected
            charset = detected[:encoding].to_s
            text = Mail::Encodings.transcode_charset(text.dup.force_encoding(charset), charset)
          end

          text
        end

        def force_utf8(str)
          str.dup.force_encoding('utf-8').encode('utf-8', invalid: :replace, undef: :replace)
        end

        def decode_utf7(str)
          str.gsub(/\+([^-]+)?-/n) do
            if $1
              ($1.tr(",", "/") + "===").unpack("m")[0].encode(Encoding::UTF_8, Encoding::UTF_16BE)
            else
              '+'
            end
          end
        end
      end
    end

    class ValueDecoder
      class << self
        include Mail::Constants

        def value_decode(str)
          # Optimization: If there's no encoded-words in the string, just return it
          return str unless str =~ ENCODED_VALUE

          lines = Mail::Encodings.send(:collapse_adjacent_encodings, str)

          lines = lines.chunk do |value|
            if value =~ ENCODED_VALUE
              $1
            else
              ''
            end
          end

          # Split on white-space boundaries with capture, so we capture the white-space as well
          lines.map do |charset, values|
            content = values.join
            if content =~ ENCODED_VALUE
              bytes = content.scan(/\=\?([^?]+)\?([QB])\?([^?]*?)\?\=/mi).map do |_, encoding, encoded|
                case encoding
                when *B_VALUES then Mail::RubyVer.decode_base64(encoded)
                when *Q_VALUES then Mail::Encodings::QuotedPrintable.decode(encoded.gsub(/_/, '=20').sub(/\=$/, ''))
                end
              end.join('')
              Mail::Encodings.transcode_charset(bytes, charset)
            else
              content
            end
          end.join('')
        end
      end
    end
  end
end
