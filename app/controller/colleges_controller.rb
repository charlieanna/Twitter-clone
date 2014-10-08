class CollegesController < ApplicationController
  def show
  end

  def index
    @colleges = College.all
  end
end
