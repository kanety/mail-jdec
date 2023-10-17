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

      def configure
        yield @@config
      end

      THREAD_KEY = :_mail_jdec

      def config
        Thread.current[THREAD_KEY] || @@config
      end

      def with_config(hash = {})
        old = Thread.current[THREAD_KEY]
        Thread.current[THREAD_KEY] = Config.new(config.attributes.merge(hash))
        yield
      ensure
        Thread.current[THREAD_KEY] = old
      end

      def enabled?
        config.enabled
      end

      def enable!
        config.enabled = true
      end

      def disable!
        config.enabled = false
      end
    end
  end
end
