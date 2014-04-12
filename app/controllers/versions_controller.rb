class VersionsController < ApplicationController
  load_and_authorize_resource

  def index
    @versions = Version.all.order(id: :desc).paginate(:page => params[:page])
  end
end
