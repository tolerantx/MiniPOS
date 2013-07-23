class VersionsController < ApplicationController
  def index
    @versions = Version.all.order(id: :desc)
  end
end
