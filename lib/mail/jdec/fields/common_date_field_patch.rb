# frozen_string_literal: true

module Mail
  module Jdec
    module CommonDateFieldPatch
      def element
        super
      rescue Mail::Field::ParseError => e
        if Jdec.enabled?
          @errors = [name, value, e]
          @element = nil
        else
          raise e
        end
      end

      def date_time
        if Jdec.enabled?
          if element
            begin
              ::DateTime.parse("#{element.date_string} #{element.time_string}")
            rescue ArgumentError => e
              require 'time'
              begin
                Time.parse(value).to_datetime
              rescue ArgumentError => e
                nil
              end
            end
          else
            nil
          end
        else
          super
        end
      end
    end
  end
end

klasses = ObjectSpace.each_object(Class).select { |klass| klass < Mail::CommonDateField }
klasses.each do |klass|
  unless klass.included_modules.include?(Mail::Jdec::CommonDateFieldPatch)
    klass.prepend Mail::Jdec::CommonDateFieldPatch
  end
end
