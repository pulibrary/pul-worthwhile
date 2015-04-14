module CurationConcern
  class GenericWorksController < ApplicationController
    include Worthwhile::CurationConcernController
    include PulCurationConcernController
    set_curation_concern_type GenericWork
  end
end