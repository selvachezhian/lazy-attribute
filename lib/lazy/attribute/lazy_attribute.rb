module Lazy
  module Attribute
    module ClassMethods

      # Including the lazy_attribute gem to the model
      #
      # @param attribute [Symbol]
      # @param [Hash] options
      # @option options [Symbol] :key (:default) if the key parameter is not set, it will take the default as the key
      # @option options [Boolean] :create_if_not_found (false) if the parameter is set as true, will create the record if the record is not available
      # @option options [Boolean] :raise_error (false) will raise exceptions
      #   ActiveRecord::RecordNotFoundException if the value set as true and the record not present <br>
      #   ActiveRecord::RecordInvalid: Validation failed exception if any validation error thrown at the time of creation missing record
      #
      # @return [none]

      def lazy_attribute(attribute, options = {})
        default_options = {raise_error: false, key: '[]', create_if_not_found: false}
        options.reverse_merge!(default_options)

        singleton_class.instance_eval do
          define_method(options[:key]) do |identifier|
            send(dynamic_find_method(options), {attribute.to_sym => identifier})
          end
        end
      end

      private

      def dynamic_find_method(options)
        create = 'or_create' if options[:create_if_not_found]
        method = ['find', create, 'by'].compact.join('_')
        method += '!' if options[:raise_error]
        method
      end
    end
  end
end