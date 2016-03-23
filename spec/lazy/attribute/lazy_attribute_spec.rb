require 'spec_helper'
include Lazy::Attribute::ClassMethods

describe 'Lazy Attribute' do



  context 'Dynamic Find' do
    it 'should return find_by if no options are passed' do
      method_name = dynamic_find_method({})
      expect(method_name).to eql('find_by')
    end

    it 'should return find_or_create_by if create_if_not_found options is passed' do
      method_name = dynamic_find_method({create_if_not_found: true})
      expect(method_name).to eql('find_or_create_by')
    end

    it 'should return find_by! if raise_error option is passed' do
      method_name = dynamic_find_method({raise_error: true})
      expect(method_name).to eql('find_by!')
    end

    it 'should return find_or_create_by! if raise_error and create_if_not_found options are passed' do
      method_name = dynamic_find_method({create_if_not_found: true, raise_error: true})
      expect(method_name).to eql('find_or_create_by!')
    end
  end

end
