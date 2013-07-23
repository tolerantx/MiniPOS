class VersionsController < ApplicationController
  def index
    @versions = Version.all.order(id: :desc).paginate(:page => params[:page])
  end
end
