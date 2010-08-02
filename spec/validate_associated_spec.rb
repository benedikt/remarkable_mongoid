require 'spec_helper'

describe 'Validates Associated' do
  before :all do
    class Should
      include Remarkable::Mongoid::Matchers
    end
    
    @should = Should.new
  end
  
  describe 'validate_association' do
    before do
      class SingleBook
        include Mongoid::Validations
        validates_associated :pages
      end
    end
    
    after do
      Object.send(:remove_const, :SingleBook)
    end
    
    it 'should be true for a book validating the association :pages' do
      matcher = @should.validate_association :pages
      matcher.matches?(SingleBook.new).should be_true
    end
  
    it 'should be false for a book validating the association :author' do
      matcher = @should.validate_association :author
      matcher.matches?(SingleBook.new).should be_false
    end
  end
  
  context 'messages' do
    before do
      matcher_subject = mock('SingleBook')
      matcher_subject.stubs(:class).returns('SingleBook')
      @association_matcher = Remarkable::Mongoid::Matchers::ValidateAssociationMatcher.new(:test)
      @association_matcher.instance_variable_set('@subject', matcher_subject)
    end
    
    describe 'description' do
      subject { @association_matcher.description }
      it { should == "validates the :test association" }
    end
    
    describe 'failure_message_for_should' do
      subject { @association_matcher.failure_message_for_should }
      it { should == "\nAssociation validation failure\nExpected: SingleBook to validate the 'test' association" }
    end
  end
  
end
