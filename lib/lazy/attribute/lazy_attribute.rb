module Lazy
  module Attribute
    module ClassMethods

      def lazy_attribute(attr, options = {})
        default_options = { raise_error: false, key: :default }
        options.reverse_merge!(default_options)

        singleton_class.instance_eval do

          if options[:key] == :default

            define_method('[]') do |identifier|
              send_dynamic_method(options, attr, identifier)
            end

          else

            define_method(options[:key]) do |identifier|
              send_dynamic_method(options, attr, identifier)
            end

          end

        end
      end

      private

      def dynamic_find_method(raise_error = false)
        raise_error ? 'find_by!' : 'find_by'
      end

      def send_dynamic_method(options, attr, identifier)
        send(dynamic_find_method(options[:raise_error]), { attr.to_sym => identifier })
      end

    end
  end
end