require 'mail'
require 'charlock_holmes'

Dir["#{__dir__}/jdec/**/*.rb"].each do |file|
  require file
end

module Mail
  module Jdec
    class << self
      attr_reader :enabled
      attr_accessor :autodetect_confidence
      attr_accessor :autodetect_skip_charsets
      attr_accessor :preferred_charsets

      def enabled?
        @@enabled
      end

      def enable
        @@enabled = true
      end

      def disable
        @@enabled = false
      end
    end

    self.enable
    self.autodetect_confidence = 50
    self.autodetect_skip_charsets = %w(utf-8 iso-8859-1)
    self.preferred_charsets = {
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
  end
end
