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
        default_options = { raise_error: false, key: :default, create_if_not_found: false }
        options.reverse_merge!(default_options)

        singleton_class.instance_eval do

          if options[:key] == :default

            define_method('[]') do |identifier|
              send_dynamic_method(options, attribute, identifier)
            end

          else

            define_method(options[:key]) do |identifier|
              send_dynamic_method(options, attribute, identifier)
            end

          end

        end
      end

      private

      def dynamic_find_method(options)
        if options[:raise_error] && options[:create_if_not_found]
          'find_or_create_by!'
        elsif options[:raise_error] && !options[:create_if_not_found]
          'find_by!'
        elsif !options[:raise_error] && options[:create_if_not_found]
          'find_or_create_by'
        elsif !options[:raise_error] && !options[:create_if_not_found]
          'find_by'
        end
      end

      def send_dynamic_method(options, attr, identifier)
        send(dynamic_find_method(options), { attr.to_sym => identifier })
      end

    end
  end
end