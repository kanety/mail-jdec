# frozen_string_literal: true

module Mail
  module Jdec
    module MessagePatch
      def decoded
        decoded = super

        if Jdec.enabled? && MessagePatch.autodetect?(self)
          detected = Detector.detect(decoded)
          if detected && detected[:type] == :text
            charset = detected[:encoding].downcase
            decoded = Mail::Encodings.transcode_charset(decoded.dup.force_encoding(charset), charset, 'utf-8')
            header[:content_type] = 'text/plain' unless has_content_type?
            header[:content_type].parameters[:charset] = charset unless has_charset?
          else
            decoded = Mail::Encodings.transcode_charset(decoded, decoded.encoding, 'utf-8')
          end
        end

        decoded
      end

      class << self
        def autodetect?(message)
          !message.has_content_type? ||
            (mime_types_for_autodetect?(message.mime_type) && !message.has_charset? && !message.attachment? && !message.multipart?)
        end

        def mime_types_for_autodetect?(mime_type)
          Jdec.config.mime_types_for_autodetect.any? do |type|
            if type.is_a?(Regexp)
              type.match?(mime_type)
            else
              type == mime_type
            end
          end
        end
      end
    end
  end
end

Mail::Message.prepend Mail::Jdec::MessagePatch
