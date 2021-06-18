class BusDrivers::ChildrenController < ApplicationController

  before_action :authenticate_bus_driver!

  def show
    @child = Child.find(params[:id])
    unless @child.parent.has_current_bus_registration?
      redirect_to bus_drivers_root_path, notice: 'Not found'
    end
  end
end
