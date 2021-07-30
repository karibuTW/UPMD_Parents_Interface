class BusDrivers::ChildrenController < ApplicationController

  before_action :authenticate_bus_driver!

  def show
    @child = Child.find(params[:id])
    unless @child.taking_bus?
      redirect_to bus_drivers_root_path, notice: 'Not found'
    end
  end


end
