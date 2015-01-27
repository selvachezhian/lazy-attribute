module Lazy
  module Attribute
    module ClassMethods

      def lazy_attribute(attr, options = {})
        default_options = { raise_error: false }

        singleton_class.instance_eval do
          define_method('[]') do |ident|
            options.reverse_merge!(default_options)
            send(dynamic_find_method(options[:raise_error]), { attr.to_sym => ident })
          end
        end
      end

      private

      def dynamic_find_method(raise_error = false)
        raise_error ? 'find_by!' : 'find_by'
      end

    end
  end
end