module Lazy
  module Attribute
    module ClassMethods

      # Including the lazy_attribute gem to the model
      #
      # @param attribute [Symbol]
      # @param [Hash] options
      # @option options [Boolean] :raise_error (false) will raise ActiveRecord::RecordNotFoundException if the value set as true and the record not present
      # @option options [Symbol] :key (:default) if the key parameter is not set, it will take the default as the key
      #
      # @return [none]
      def lazy_attribute(attribute, options = {})
        default_options = { raise_error: false, key: :default }
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

      def dynamic_find_method(raise_error = false)
        raise_error ? 'find_by!' : 'find_by'
      end

      def send_dynamic_method(options, attr, identifier)
        send(dynamic_find_method(options[:raise_error]), { attr.to_sym => identifier })
      end

    end
  end
end