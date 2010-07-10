# remarkable_mongoid
RSpec Matchers for Mongoid

## Matchers

Associations

* reference_one
* reference_many
* be_referenced_in
* embed_one
* embed_many
* be_embedded_in

Validations

* validates_uniqueness_of
* All ActiveModel validations from [Remarkable::ActiveModel](http://github.com/remarkable/remarkable/tree/master/remarkable_activemodel)

## Usage

    describe Book do
      it { should reference_one :author }
    end
    
## Copyright

Copyright (c) 2010 Brian Cardarella. See LICENSE for details.
