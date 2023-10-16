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

Mail::StructuredField.prepend Mail::Jdec::StructuredFieldPatch
