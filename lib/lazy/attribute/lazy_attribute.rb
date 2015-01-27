module Lazy
  module Attribute
    module ClassMethods

      def lazy_attribute(attr, options = {})
        default_options = { raise_error: false, key: :default }
        options.reverse_merge!(default_options)

        singleton_class.instance_eval do
          # options[:key] == :default ? send(:define_method, '[]') : send(:define_method, options[:key]) do |identifier|
          #   key = find_key(identifier)
          #
          #   check_key(key)
          #
          #   send(dynamic_find_method(options[:raise_error]), { attr.to_sym => find_identifier(identifier) })
          #
          #   # send('find_by', email: 'xyz')
          # end

          if options[:key] == :default
            define_method('[]') do |identifier|
              key = find_key(identifier)

              check_key(key)

              send(dynamic_find_method(options[:raise_error]), { attr.to_sym => find_identifier(identifier) })
            end

          else

            define_method(options[:key]) do |identifier|
              key = find_key(identifier)

              check_key(key)

              send(dynamic_find_method(options[:raise_error]), { attr.to_sym => find_identifier(identifier) })
            end
          end

        end
      end

      def dynamic_define_method(key)
        puts key
        key == :default ? "define_method('[]')" : "define_method(#{key})"
      end

      private

      def dynamic_find_method(raise_error = false)
        raise_error ? 'find_by!' : 'find_by'
      end

      def find_key(ident)
        ident.kind_of?(Array) ? ident.first : :default
      end

      def check_key(key)
        raise "Key parameter should be a symbol.  You have passed #{key}" unless key.is_a?(Symbol)
      end

      def find_identifier(identifier)
        identifier.kind_of?(Array) ? identifier[1] : identifier
      end

    end
  end
end