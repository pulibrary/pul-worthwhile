module PulCurationConcernController
  extend ActiveSupport::Concern

  def attributes_for_actor
    # params[hash_key_for_curation_concern]
    params.require(hash_key_for_curation_concern).permit!
  end

  # Overriding to avoid cehcking acceptance of user agreement
  def create
    if actor.create
      after_create_response
    else
      setup_form
      respond_with([:curation_concern, curation_concern]) do |wants|
        wants.html { render 'new', status: :unprocessable_entity }
      end
    end
  end

end