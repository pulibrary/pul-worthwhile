module PulCurationConcernController
  extend ActiveSupport::Concern

  def attributes_for_actor
    # params[hash_key_for_curation_concern]
    params.require(hash_key_for_curation_concern).permit!
  end

end