module Lazy
  module Attribute
    module ClassMethods

      def lazy_attribute(attr, options = {})
        singleton_class.instance_eval do
          define_method('[]') do |ident|
            options[:raise_error] ||= false
            send(dynamic_find_method(options[:raise_error]), { attr.to_sym => ident })
          end
        end
      end

      def dynamic_find_method(raise_error = false)
        raise_error ? 'find_by!' : 'find_by'
      end

    end
  end
end