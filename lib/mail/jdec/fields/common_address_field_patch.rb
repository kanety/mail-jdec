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
    end
  end
end

klasses = ObjectSpace.each_object(Class).select { |klass| klass < Mail::CommonAddressField }
klasses.each do |klass|
  unless klass.included_modules.include?(Mail::Jdec::CommonAddressFieldPatch)
    klass.prepend Mail::Jdec::CommonAddressFieldPatch
  end
end
