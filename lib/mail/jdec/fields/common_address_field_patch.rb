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

klasses = ObjectSpace.each_object(Class).select { |klass| klass < Mail::CommonAddressField }
klasses.each do |klass|
  klass.prepend Mail::Jdec::CommonAddressFieldPatch
end
