# frozen_string_literal: true

module Mail
  module Jdec
    module StructuredFieldPatch
      def initialize(name = nil, value = nil, charset = nil)
        value = Decoder.decode_if_needed(value) if Jdec.enabled?
        super
      end
    end
  end
end

unless Mail::StructuredField.included_modules.include?(Mail::Jdec::StructuredFieldPatch)
  Mail::StructuredField.prepend Mail::Jdec::StructuredFieldPatch
end
