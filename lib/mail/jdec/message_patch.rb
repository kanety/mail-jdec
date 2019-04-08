module Mail
  module Jdec
    module MessagePatch
      def decoded
        decoded = super

        if Jdec.enabled? && (!has_content_type? || (text? && !has_charset? && !attachment? && !multipart?))
          detected = Detector.detect(decoded)
          if detected && detected[:type] == :text
            charset = detected[:encoding].downcase
            decoded = Mail::Encodings.transcode_charset(decoded.dup.force_encoding(charset), charset, 'utf-8')
            header[:content_type] = 'text/plain'
            header[:content_type].parameters[:charset] = charset
          else
            decoded = Mail::Encodings.transcode_charset(decoded, decoded.encoding, 'utf-8')
          end
        end

        decoded
      end
    end
  end
end

unless Mail::Message.included_modules.include?(Mail::Jdec::MessagePatch)
  Mail::Message.prepend Mail::Jdec::MessagePatch
end
