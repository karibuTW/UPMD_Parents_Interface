class Parents::ProfileController < ApplicationController
  before_action :authenticate_parent!

  def profile
  end
end
