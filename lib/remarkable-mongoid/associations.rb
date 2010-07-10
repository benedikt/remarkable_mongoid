module Remarkable::Mongoid
  module Matchers
    def reference_many(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencesMany)
    end
    
    def be_referenced_in(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencedIn)
    end

    def embed_many(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::EmbedsMany)
    end
    
    def be_embedded_in(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::EmbeddedIn)
    end
    
    class AssociationMatcher
      attr_accessor :attr, :association_type

      def initialize(attr, association_type)
        self.attr             = attr.to_s
        self.association_type = association_type
      end

      def matches?(subject)
        @subject = subject
        a        = @subject.associations.select { |k,v| v.association == association_type }
        a.detect { |k| k.first == attr } != nil
      end
    end
  end
end