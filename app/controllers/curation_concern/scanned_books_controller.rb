# Generated via
#  `rails generate worthwhile:work ScannedBook`

class CurationConcern::ScannedBooksController < ApplicationController
  include Worthwhile::CurationConcernController
  include PulCurationConcernController
  set_curation_concern_type ScannedBook


  def update
    if actor.update(refresh_metadata: !params[:refresh_metadata].nil? && params[:refresh_metadata])
      byebug
      after_update_reponse
    else
      setup_form
      respond_with([:curation_concern, curation_concern]) do |wants|
        wants.html { render 'edit', status: :unprocessable_entity }
      end
    end
  end

end