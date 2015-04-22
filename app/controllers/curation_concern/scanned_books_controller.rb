# Generated via
#  `rails generate worthwhile:work ScannedBook`

class CurationConcern::ScannedBooksController < ApplicationController
  include Worthwhile::CurationConcernController
  include PulCurationConcernController
  set_curation_concern_type ScannedBook

  def update
    if actor.update(refresh_metadata: !params[:refresh_metadata].nil? && params[:refresh_metadata])

      # FIXME: The after_update_reponse method causes an error that is difficult
      #   to trace. The method's code is pasted here until the eerror is fixed.
      if actor.visibility_changed?
        redirect_to confirm_curation_concern_permission_path(curation_concern)
      else
        respond_with([:curation_concern, curation_concern])
      end
    else
      setup_form
      respond_with([:curation_concern, curation_concern]) do |wants|
        wants.html { render 'edit', status: :unprocessable_entity }
      end
    end
  end
end