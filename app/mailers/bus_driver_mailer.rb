class BusDriverMailer < ApplicationMailer
  def new_child
    @child = params[:child]
    mail(to: BusDriver.all.pluck(:email), subject: 'A new child has been created') if @child.taking_bus
  end
  
  def modified_child
    @child = params[:child]
    mail(to: BusDriver.all.pluck(:email), subject: 'An existing child has been modified') if @child.taking_bus
  end

  def deleted_child
    @child = params[:child]
    mail(to: BusDriver.all.pluck(:email), subject: 'A child has been deleted')
  end
end
