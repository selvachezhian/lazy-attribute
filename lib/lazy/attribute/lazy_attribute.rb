module Lazy
  module Attribute
    module ClassMethods
      def lazy_attribute(attribute, options = {})
        default_options = { raise_error: false, key: [], create_if_not_found: false }
        options.reverse_merge!(default_options)

        singleton_class.instance_eval do
            define_method(options[:key]) do |identifier|
              send(dynamic_find_method(options), { attribute.to_sym => identifier })
            end
        end
      end

      def dynamic_find_method(options)
        create ='or_create' if options[:create_if_not_found]
        error = '!' if options[:raise_error]

        method = ['find', create, 'by'].compact.join('_')
        [method, error].compact.join('')
      end
    end
  end
end