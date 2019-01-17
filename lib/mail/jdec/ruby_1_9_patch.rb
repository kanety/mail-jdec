module Mail
  module Jdec
    module Ruby19Patch
      def pick_encoding(charset)
        if Jdec.enabled?
          Jdec.preferred_charsets.each do |from, to|
            if charset.to_s.downcase == from
              return Encoding.find(to)
            end
          end
        end
        super
      end
    end
  end
end

unless Mail::Ruby19.singleton_class.included_modules.include?(Mail::Jdec::Ruby19Patch)
  Mail::Ruby19.singleton_class.prepend Mail::Jdec::Ruby19Patch
end
