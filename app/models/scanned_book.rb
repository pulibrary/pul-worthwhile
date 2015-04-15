# Generated via
#  `rails generate worthwhile:work ScannedBook`
class ScannedBook < ActiveFedora::Base
  include ::CurationConcern::Work
  include Sufia::GenericFile::Metadata

  property :portion_note, predicate: ::RDF::URI.new(::RDF::DC.description), multiple: false
  property :description, predicate: ::RDF::URI.new(::RDF::DC.abstract), multiple: false
  property :access_policy, predicate: ::RDF::URI.new(::RDF::DC.accessRights), multiple: false
  property :use_and_reproduction, predicate: ::RDF::URI.new(::RDF::DC.rights), multiple: false
  property :src_metadata_id, predicate: ::RDF::URI.new('http://library.princeton.edu/terms/metadata_id'), multiple: false

  validates_presence_of :src_metadata_id,  message: 'You must provide a source metadata id.'
  validates_presence_of :access_policy,  message: 'You must choose an Access Policy statement.'
  validates_presence_of :use_and_reproduction,  message: 'You must provide a use statement.'
end
