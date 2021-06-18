class BusDrivers::ProfileController < ApplicationController
  before_action :authenticate_bus_driver!

  def profile
    @q = Child.ransack(params[:q])
    @children = @q.result.includes(:parent).page(params[:page]).to_a.filter { |c| c.parent.has_current_bus_registration? }
  end

end
