require 'rails_helper'

describe DeviseHelper do
  describe '#resource_name' do
    it 'returns ":user"' do
      expect(helper.resource_name).to eql(:user)
    end
  end

  describe '#resource' do
    it 'returns user instance' do
      expect(helper.resource).to be_an_instance_of(User)
    end
  end

  describe '#resource_class' do
    it 'returns User' do
      expect(helper.resource_class).to eql(User)
    end
  end
end
