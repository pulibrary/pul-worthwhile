# Generated via
#  `rails generate worthwhile:work ScannedBook`

require 'active_fedora/noid'
#require 'marc'
require 'pul_metadata_services'
require 'pul_metadata_services/pulfa_record'

class ScannedBook < ActiveFedora::Base
  include ::CurationConcern::Work
  include Sufia::GenericFile::Metadata
  include ::PulMetadataServices
  include ::NoidBehaviors

  property :portion_note, predicate: ::RDF::URI.new(::RDF::DC.description), multiple: false
  property :description, predicate: ::RDF::URI.new(::RDF::DC.abstract), multiple: false
  property :access_policy, predicate: ::RDF::URI.new(::RDF::DC.accessRights), multiple: false
  property :use_and_reproduction, predicate: ::RDF::URI.new(::RDF::DC.rights), multiple: false
  property :source_metadata_identifier, predicate: ::RDF::URI.new('http://library.princeton.edu/terms/metadata_id'), multiple: false
  property :source_metadata, predicate: ::RDF::URI.new('http://library.princeton.edu/terms/source_metadata'), multiple: false

  validates_presence_of :source_metadata_identifier,  message: 'You must provide a source metadata id.'
  validates_presence_of :access_policy,  message: 'You must choose an Access Policy statement.'
  validates_presence_of :use_and_reproduction,  message: 'You must provide a use statement.'


  # Retrieves EAD recrord from pulfa
  #  * stores the full EAD record in source_metadata
  #  * extracts title, creator, date, and publisher from the EAD and sets those fields accordingly
  def apply_pulfa_data
    self.source_metadata = retrieve_from_pulfa(source_metadata_identifier)
    ead_record = PulMetadataServices::PulfaRecord.new(self.source_metadata)
    self.title = [ead_record.component_title]
    self.creator = ead_record.component_creators
    self.date_created = [ead_record.component_date]
    self.publisher = ead_record.collection_creators
  end

  # Retrieves MARC record from bibdata service
  #  * stores the full MARC record in source_metadata
  #  * extracts title, creator, date, and publisher from the MARC and sets those fields accordingly
  def apply_bibdata
    # retrieve_from_bibdata from pul_metadata_services
    # marc record object also is extended by pul_metadata_services
    # with convience methods for title, creator, etc.
    marc_source = retrieve_from_bibdata(source_metadata_identifier)
    #FIXME - review this exception handler
    begin
      self.source_metadata = marc_source
    rescue => e
      logger.error("Record ID #{self.source_metadata_identifier} is malformed. Error:")
      logger.error("#{e.class}: #{e.message}")
    end
    marc_record = MARC::XMLReader.new(StringIO.new(marc_source)).first #ScannedBook.negotiate_record(marc_source)
    self.title = marc_record.title
    self.creator = marc_record.creator
    self.date_created = [marc_record.date]
    self.publisher = marc_record.publisher
  end

  def pulfa_connection
    Faraday.new(:url => 'http://findingaids.princeton.edu/collections/')
  end

  def bibdata_connection
    Faraday.new(:url => 'http://bibdata.princeton.edu/bibliographic/')
  end

  def refresh_metadata
    apply_external_metadata
  end

  def apply_external_metadata
    if is_bibdata?
      apply_bibdata()
    else
      apply_pulfa_data()
    end
  end

  private

  # http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  def is_bibdata?
    /\A[-+]?\d+\z/ === self.source_metadata_identifier
  end

  def assign_id
    noid_service.mint
  end

  private

  def noid_service
    @noid_service ||= ActiveFedora::Noid::Service.new
  end

end


