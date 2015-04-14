# Generated via
#  `rails generate worthwhile:work ScannedBook`
class ScannedBook < ActiveFedora::Base
  include ::CurationConcern::Work
  # include ::CurationConcern::WithBasicMetadata
  include Sufia::GenericFile::Metadata
  validates_presence_of :title,  message: 'Your work must have a title.'
end
