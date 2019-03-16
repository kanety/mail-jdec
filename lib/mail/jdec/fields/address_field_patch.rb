module Mail
  module Jdec
    module AddressFieldPatch
      def parse(val = value)
        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          @errors = [name, val, e]
          @address_list = AddressList.new('')
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

klasses = ObjectSpace.each_object(Class).select { |klass| klass < Mail::CommonAddress }
klasses.each do |klass|
  unless klass.included_modules.include?(Mail::Jdec::AddressFieldPatch)
    klass.prepend Mail::Jdec::AddressFieldPatch
  end
end
