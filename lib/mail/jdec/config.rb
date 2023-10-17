# frozen_string_literal: true

module Mail
  module Jdec
    class Config
      NAMES = [
        :enabled,
        :autodetect_confidence, :autodetect_skip_charsets, :mime_types_for_autodetect,
        :preferred_charsets, :keep_field_order
      ]
      NAMES.each do |name|
        attr_accessor name
      end

      def initialize(attrs = {})
        attrs.each do |key, val|
          send("#{key}=", val)
        end
      end

      def attributes
        NAMES.each_with_object({}) do |name, hash|
          hash[name] = send(name)
        end
      end
    end
  end
end
