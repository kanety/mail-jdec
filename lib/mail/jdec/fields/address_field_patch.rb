module Mail
  module Jdec
    module AddressFieldPatch
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
  unless klass.included_modules.include?(Mail::Jdec::AddressFieldPatch)
    klass.prepend Mail::Jdec::AddressFieldPatch
  end
end
