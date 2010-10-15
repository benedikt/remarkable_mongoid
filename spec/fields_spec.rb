require 'spec_helper'

describe 'Mongoid Fields' do
  before :all do
    class Should
      include Remarkable::Mongoid::Matchers
    end

    @should = Should.new
  end

  describe 'have_field' do
    before :all do
      class SingleBook
        def self.add_dirty_methods(*args); end
        include Mongoid::Fields
        field :name
        field :published_on, :type => Date
      end
    end

    context 'without given type' do
      it 'should be true for a book with field name' do
        matcher = @should.have_field :name
        matcher.matches?(SingleBook.new).should be_true
      end

      it 'should be true for a book without field author' do
        matcher = @should.have_field :author
        matcher.matches?(SingleBook.new).should be_false
      end
    end
    
    context 'with given type' do
      it 'should be true for a book with field published_on of type Date' do
        matcher = @should.have_field :published_on, :type => Date
        matcher.matches?(SingleBook.new).should be_true
      end

      it 'should be true for a book with field published_on of type Array' do
        matcher = @should.have_field :published_on, :type => Array
        matcher.matches?(SingleBook.new).should be_false
      end
    end
  end

  context 'messages' do
    before :all do
      class Model
        def self.add_dirty_methods(*args); end
        include Mongoid::Fields
        field :test
      end
    end

    before do
      @association_matcher = Remarkable::Mongoid::Matchers::HasFieldMatcher.new(:test, { :type => Date })
      @association_matcher.matches?(Model)
    end

    describe 'description' do
      subject { @association_matcher.description }
      it { should == "have field test of type Date" }
    end

    describe 'failure_message_for_should' do
      subject { @association_matcher.failure_message_for_should }
      it { should == "expected Model to have field test of type Date" }
    end

    describe 'failure_message_for_should_not' do
      subject { @association_matcher.failure_message_for_should_not }
      it { should == "expected Model to not have field test of type Date" }
    end
  end
end
