# frozen_string_literal: true

module Mail
  module Jdec
    module FieldListPatch
      def insert_field(field)
        if Mail::Jdec.enabled? && Mail::Jdec.config.keep_field_order
          push field
        else
          super
        end
      end
    end
  end
end

Mail::FieldList.prepend Mail::Jdec::FieldListPatch
