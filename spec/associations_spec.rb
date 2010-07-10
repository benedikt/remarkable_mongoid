require 'spec_helper'

describe 'Mongoid Associations' do
  before :all do
    class Should
      include Remarkable::Mongoid::Matchers
    end
    
    @should = Should.new
  end
  
  context 'embedding' do
    before :all do
      class SingleBook
        include Mongoid::Associations
        embeds_many :pages,  :class_name => "SinglePage"
        embed_one   :author, :class_name => "SingleAuthor"
      end
      
      class SinglePage
        include Mongoid::Associations
        embedded_in :book, :clas_name => "SingleBook", :inverse_of => :pages
      end
    end

    describe 'embed_one' do
      it 'should be true for a book embedding one author' do
        matcher = @should.embed_one :author
        matcher.matches?(SingleBook.new).should be_true
      end
      
      it 'should be false for a book embedding one publisher' do
        matcher = @should.embed_one :publisher
        matcher.matches?(SingleBook.new).should be_false
      end
    end
    
    describe 'embed_many' do
      it 'should be true for a book embedding many pages' do
        matcher = @should.embed_many :pages
        matcher.matches?(SingleBook.new).should be_true
      end
      
      it 'should be false for a book embedding many words' do
        matcher = @should.embed_many :words
        matcher.matches?(SingleBook.new).should be_false
      end
    end
    
    describe 'embedded_in' do
      it 'should be true for a page embedded in a book' do
        matcher = @should.be_embedded_in :book
        matcher.matches?(SinglePage.new).should be_true
      end
      
      it 'should be false for a page embedded in a newspaper' do
        matcher = @should.be_embedded_in :newspaper
        matcher.matches?(SinglePage.new).should be_false
      end
    end
  end
  
  context 'referencing' do
    before :all do
      class SingleOwner
        def self.set_callback(*args); end
        include Mongoid::Associations
        references_many :dogs,   :class_name => "SingleDog"
        references_one  :friend, :class_name => "SingleFriend"
      end
      
      class SingleDog
        def self.set_callback(*args); end
        def self.add_dirty_methods(*args); end
        def self.index(*args); end
        include Mongoid::Fields
        include Mongoid::Associations
        referenced_in :owner, :clas_name => "SingleOwner", :inverse_of => :dogs
      end
    end

    describe 'reference_one' do
      it 'should be true for an owner having one friend' do
        matcher = @should.reference_one :friend
        matcher.matches?(SingleOwner.new).should be_true
      end
      
      it 'should be false for an owner having one boss' do
        matcher = @should.reference_one :boss
        matcher.matches?(SingleOwner.new).should be_false
      end
    end
    
    describe 'reference_many' do
      it 'should be true for an owner having many dogs' do
        matcher = @should.reference_many :dogs
        matcher.matches?(SingleOwner.new).should be_true
      end
      
      it 'should be false for an owner having many cats' do
        matcher = @should.reference_many :cats
        matcher.matches?(SingleOwner.new).should be_false
      end
    end
    
    describe 'be_referenced_in' do
      it 'should be true for a dog belonging to an owner' do
        matcher = @should.be_referenced_in :owner
        matcher.matches?(SingleDog.new).should be_true
      end
      
      it 'should be false for a dog belonging to a cat' do
        matcher = @should.be_referenced_in :stranger
        matcher.matches?(SingleDog.new).should be_false
      end
    end
  end
  
  context 'messages' do
    before do
      @association_matcher = Remarkable::Mongoid::Matchers::AssociationMatcher.new(:test, "Some::Test")
    end
    
    describe 'description' do
      subject { @association_matcher.description }
      it { should == "has Test association :test" }
    end
    
    describe 'failure_message_for_should' do
      subject { @association_matcher.failure_message_for_should }
      it { should == "\nTest association failure\nExpected: 'test'"}
    end
  end
end