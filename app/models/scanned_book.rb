# Generated via
#  `rails generate worthwhile:work ScannedBook`
class ScannedBook < ActiveFedora::Base
  include ::CurationConcern::Work
  include Sufia::GenericFile::Metadata
  include PulMetadataServices::ExternalMetadataSource

  property :portion_note, predicate: ::RDF::URI.new(::RDF::DC.description), multiple: false
  property :description, predicate: ::RDF::URI.new(::RDF::DC.abstract), multiple: false
  property :access_policy, predicate: ::RDF::URI.new(::RDF::DC.accessRights), multiple: false
  property :use_and_reproduction, predicate: ::RDF::URI.new(::RDF::DC.rights), multiple: false
  property :source_metadata_id, predicate: ::RDF::URI.new('http://library.princeton.edu/terms/metadata_id'), multiple: false
  property :source_metadata, predicate: ::RDF::URI.new('http://library.princeton.edu/terms/source_metadata'), multiple: false

  validates_presence_of :source_metadata_id,  message: 'You must provide a source metadata id.'
  validates_presence_of :access_policy,  message: 'You must choose an Access Policy statement.'
  validates_presence_of :use_and_reproduction,  message: 'You must provide a use statement.'


  # Retrieves EAD recrord from pulfa
  #  * stores the full EAD record in source_metadata
  #  * extracts title, creator, date, and publisher from the EAD and sets those fields accordingly
  def apply_pulfa_data
    ead_source = retrieve_from_pulfa
    self.source_metadata = ead_source
    ead_record = ScannedBook.negotiate_ead(ead_source)
    self.title = ScannedBook.title_from_ead(ead_record)
    self.creator = ScannedBook.creator_from_ead(ead_record)
    self.date_created = ScannedBook.date_from_ead(ead_record)
    self.publisher = ScannedBook.publisher_from_ead(ead_record)
  end

  # Retrieves MARC recrord from bibdata service
  #  * stores the full MARC record in source_metadata
  #  * extracts title, creator, date, and publisher from the MARC and sets those fields accordingly
  def apply_bibdata
    marc_source = retrieve_from_bibdata
    self.source_metadata = marc_source
    marc_record = ScannedBook.negotiate_record(marc_source)
    self.title = ScannedBook.title_from_marc(marc_record)
    self.creator = ScannedBook.creator_from_marc(marc_record)
    self.date_created = [ScannedBook.date_from_marc(marc_record)]
    self.publisher = ScannedBook.publisher_from_marc(marc_record)
  end

  def retrieve_from_pulfa
    response = pulfa_connection.get(source_metadata_id.gsub('_','/')+".xml?scope=record" )
    response.body
  end

  def pulfa_connection
    Faraday.new(:url => 'http://findingaids.princeton.edu/collections/')
  end

  def bibdata_connection
    Faraday.new(:url => 'http://bibdata.princeton.edu/bibliographic/')
  end

  def retrieve_from_bibdata
    response = bibdata_connection.get(source_metadata_id)
    response.body
  end


  def refresh_metadata
    apply_external_metadata
  end


  # Applies relevant metadata from external systems
  def apply_external_metadata
    #if self.source_metadata_id.to_i.is_a? Integer
    if is_bibdata?
      apply_bibdata
    else
      apply_pulfa_data
    end
  end

  private

  # http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  def is_bibdata?
    /\A[-+]?\d+\z/ === self.source_metadata_id
  end

end


