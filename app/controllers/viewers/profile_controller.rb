class Viewers::ProfileController < ApplicationController
  before_action :authenticate_viewer!
  def profile
  end
end
