# frozen_string_literal: true

module Mail
  module Jdec
    module UnstructuredFieldPatch
      def initialize(name = nil, value = nil, charset = nil)
        value = Decoder.decode_if_needed(value) if Jdec.enabled?
        super
      end
    end
  end
end

unless Mail::UnstructuredField.included_modules.include?(Mail::Jdec::UnstructuredFieldPatch)
  Mail::UnstructuredField.prepend Mail::Jdec::UnstructuredFieldPatch
end
