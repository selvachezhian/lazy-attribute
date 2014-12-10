require 'lazy/attribute/version'
require 'lazy/attribute/lazy_attribute'

ActiveRecord::Base.extend(Lazy::Attribute::ClassMethods) if defined?(ActiveRecord)