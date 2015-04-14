# Generated via
#  `rails generate worthwhile:work ScannedBook`

class CurationConcern::ScannedBooksController < ApplicationController
  include Worthwhile::CurationConcernController
  include PulCurationConcernController
  set_curation_concern_type ScannedBook
end
