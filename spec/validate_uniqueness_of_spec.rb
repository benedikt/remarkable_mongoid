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
        validates_uniqueness_of :title, :message => 'Test message', :scope => :author_id
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
    
    context 'with scope' do
      it 'should be true for a book validating the uniqueness scoped_to author_id' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:author_id)
        matcher.matches?(SingleBook.new).should be_true
      end
      
      it 'should be false for a book validating the uniqueness scoped_to reader_id' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:reader_id)
        matcher.matches?(SingleBook.new).should be_false
      end
    end

    context 'with scope and message' do
      it 'should be true for a book validating the uniqueness with good scope and message' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:author_id).with_message('Test message')
        matcher.matches?(SingleBook.new).should be_true
      end
      
      it 'should be false for a book validating the uniqueness with good scope and bad message' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:author_id).with_message('Bad message')
        matcher.matches?(SingleBook.new).should be_false
      end

      it 'should be false for a book validating the uniqueness with bad scope and good message' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:reader_id).with_message('Test message')
        matcher.matches?(SingleBook.new).should be_false
      end

      it 'should be false for a book validating the uniqueness with bad scope and bad message' do
        matcher = @should.validate_uniqueness_of(:title).scoped_to(:reader_id).with_message('Bad message')
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