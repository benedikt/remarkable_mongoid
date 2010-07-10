require 'spec_helper'

describe "RemarkableMongoid" do
  it 'should define Remarkable::Mongoid' do
    expect {
      Remarkable::Mongoid
    }.to_not raise_error
  end
end
