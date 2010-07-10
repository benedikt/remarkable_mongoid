require 'spec_helper'

describe "Remarkable::Mongoid" do
  it 'should define Remarkable::Mongoid' do
    defined?(Remarkable::Mongoid).should be_true
  end
end

describe 'Remarkable::ActiveModel' do
  it 'should include the Remarkable ActiveModel validation matchers' do
    defined?(Remarkable::ActiveModel).should be_true
  end
end