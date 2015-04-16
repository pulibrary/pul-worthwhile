# Generated via
#  `rails generate worthwhile:work ScannedBook`
module CurationConcern
  class ScannedBookActor < CurationConcern::GenericWorkActor

    def create
      was_successful = super
      update_metadata if was_successful
      return was_successful
    end

    def update(options={})
      was_successful = super()
      if was_successful && options.fetch(:refresh_metadata, false)
        update_metadata
      end
      return was_successful
    end

    def update_metadata
      curation_concern.apply_external_metadata
    end

  end
end
