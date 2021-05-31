class BusDrivers::ProfileController < ApplicationController
  before_action :authenticate_bus_driver!
  def profile
  end
end
