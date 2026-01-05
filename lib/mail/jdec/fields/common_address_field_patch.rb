# frozen_string_literal: true

module Mail
  module Jdec
    module CommonAddressFieldPatch
      def element
        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          @errors = [name, value, e]
          @element = AddressList.new('')
        else
          raise e
        end
      end

      def errors
        @errors
      end

      def address_list
        element
      end
    end
  end
end

Mail::CommonAddressField.prepend Mail::Jdec::CommonAddressFieldPatch
