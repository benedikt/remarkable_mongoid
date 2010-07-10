require 'spec_helper'

describe 'Validates Uniqueness Of' do
  before :all do
    class Should
      include Remarkable::Mongoid::Matchers
    end
    
    @should = Should.new
  end
  
  describe 'validate_uniqueness_of' do
    before :all do
      class SingleBook
        include Mongoid::Validations
        validates_uniqueness_of :title, :message => 'Test message'
      end
    end

    it 'should be true for a book validating the uniqueness of title' do
      matcher = @should.validate_uniqueness_of :title
      matcher.matches?(SingleBook.new).should be_true
    end
    
    it 'should be false for a book validating the uniqueness of author' do
      matcher = @should.validate_uniqueness_of :author
      matcher.matches?(SingleBook.new).should be_false
    end
    
    context 'with message' do
      it 'should be true for a book validating the uniqueness of title' do
        matcher = @should.validate_uniqueness_of(:title).with_message('Test message')
        matcher.matches?(SingleBook.new).should be_true
      end

      it 'should be false for a book validating the uniqueness of title with message "Bad message"' do
        matcher = @should.validate_uniqueness_of(:author).with_message('Bad message')
        matcher.matches?(SingleBook.new).should be_false
      end
    end
  end
  
  context 'messages' do
    before do
      @association_matcher = Remarkable::Mongoid::Matchers::ValidateUniquenessOfMatcher.new(:test)
    end
    
    describe 'description' do
      subject { @association_matcher.description }
      it { should == "validates that :test is unique" }
    end
    
    describe 'failure_message_for_should' do
      subject { @association_matcher.failure_message_for_should }
      it { should == "\nUniqueness validation failure\nExpected: 'test' to be unique" }
    end
  end
  
end