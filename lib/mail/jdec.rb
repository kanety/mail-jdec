# frozen_string_literal: true

require 'mail'
require 'charlock_holmes'

Dir["#{__dir__}/jdec/**/*.rb"].each do |file|
  require file
end

module Mail
  module Jdec
    class << self
      @@enabled = true
      @@config = Config.new(
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
        }
      )

      def enabled?
        @@enabled
      end

      def enable!
        @@enabled = true
      end

      def disable!
        @@enabled = false
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
