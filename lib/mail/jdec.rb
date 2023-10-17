# frozen_string_literal: true

require 'mail'
require 'charlock_holmes'

Dir["#{__dir__}/jdec/**/*.rb"].each do |file|
  require file
end

module Mail
  module Jdec
    class << self
      @@config = Config.new(
        enabled: true,
        autodetect_confidence: 50,
        autodetect_skip_charsets: %w(),
        mime_types_for_autodetect: [%r{^text/}, 'message/delivery-status', 'message/disposition-notification'],
        preferred_charsets: {
          'iso-2022-jp' => 'cp50221',
          'iso-2022-jp-1' => 'cp50221',
          'iso-2022-jp-2' => 'cp50221',
          'iso-2022-jp-3' => 'cp50221',
          'iso-2022-jp-2004' => 'cp50221',
          'shift_jis' => 'cp932',
          'shift-jis' => 'cp932',
          'x_sjis' => 'cp932',
          'x-sjis' => 'cp932'
        },
        keep_field_order: false
      )

      def enabled?
        @@config.enabled
      end

      def enable!
        @@config.enabled = true
      end

      def disable!
        @@config.enabled = false
      end

      def configure
        yield @@config
      end

      def config
        @@config
      end

      def with_config(hash = {})
        Config.set_current(hash)
        yield
      ensure
        Config.unset_current
      end
    end
  end
end
