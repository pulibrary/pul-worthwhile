module CurationConcern
  class GenericFilesController < ApplicationController
    include Worthwhile::FilesController
    
    # Whitelists *all* attributes submitted.
    # See: https://github.com/ryanb/cancan/issues/835#issuecomment-18663815  
    def generic_file_params
      params.require(:generic_file).permit!
    end
  end
end