module Lazy
  module Attribute
    module ClassMethods

      def lazy_attribute(attr)
        singleton_class.instance_eval do
          define_method('[]') do |ident|
            send('find_by', { attr.to_sym => ident })
          end
        end
      end

    end
  end
end