class ExternalMetadataController < ApplicationController
  include ExternalMetadataHelper

  def show
    respond_to do |format|
      format.json { render json: get_preview(params[:id]) }
    end
  end

end
