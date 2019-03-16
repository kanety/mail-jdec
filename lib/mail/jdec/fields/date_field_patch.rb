module Mail
  module Jdec
    module DateFieldPatch
      def date_time
        super
      rescue ArgumentError, Mail::Field::ParseError => e
        if Jdec.enabled?
          begin
            require 'time'
            Time.parse(value).to_datetime
          rescue ArgumentError => e
            nil
          end
        else
          raise e
        end
      end
    end
  end
end

module Mail
  class DateField < StructuredField
    def initialize(value = nil, charset = nil)
      super(CAPITALIZED_FIELD, self.class.normalize_datetime(value), charset)
    end

    def self.normalize_datetime(string)
      if Utilities.blank?(string)
        datetime = ::DateTime.now
      else
        stripped = string.to_s.gsub(/\(.*?\)/, '').squeeze(' ')
        begin
          datetime = ::DateTime.parse(stripped)
        rescue ArgumentError => e
          raise unless 'invalid date' == e.message
        end
      end

      if datetime
        datetime.strftime('%a, %d %b %Y %H:%M:%S %z')
      else
        string
      end
    end
  end
end

klasses = ObjectSpace.each_object(Class).select { |klass| klass < Mail::CommonDate }
klasses.each do |klass|
  unless klass.included_modules.include?(Mail::Jdec::DateFieldPatch)
    klass.prepend Mail::Jdec::DateFieldPatch
  end
end
