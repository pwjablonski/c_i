class RegistrationsController < ApplicationController
#  before_action :set_event_registration, only: [:show, :edit, :update, :destroy]

  # POST /event_registrations
  # POST /event_registrations.json
  def create
      @notice = ""
      @event = Event.find(params[:event_id])
      @student = Student.find(params[:student_id])
      status = params[:status]
      
      @registration = @event.add_student(@student, status)
     
      
      if @registration == nil
        @notice = @notice + "#{@student.first_name} #{@student.last_name} already registered  "
      else
        @notice = @notice + "#{@student.first_name} #{@student.last_name} successfully enrolled  "
      end
      
      
#      user_email_string = params[:student_email]
#      user_email_list = user_email_string.split(",")
#      
#      
#      user_email_list.each do |user_email|
#          if User.find_by(email: user_email).try(:student?)
#              @student = User.find_by(email: user_email).student
#              
#              @event_registration = @event.add_student(@student)
#              
#              if @event_registration == nil
#                  @notice = @notice + "#{user_email} already registered  "
#              else
#                  @event_registration.save
#                  @notice = @notice + "#{user_email} successfully enrolled  "
#              end
#              else
#              @notice = @notice + "#{user_email} not found  "
#          end
#      end

      respond_to do |format|
          format.html {redirect_to event_path(@event),
              notice: @notice }
      end

  end
  
  def accept
     @registration = Registration.find(params[:id])
     @registration.update_attribute(:status, "accepted")
     if user_signed_in?
         redirect_to @registration.event
     else
         redirect_to root_path
     end
     
  end
  
  def decline
      @registration = Registration.find(params[:id])
      @registration.update_attribute(:status, "declined")
      if user_signed_in?
          redirect_to @registration.event
      else
          redirect_to root_path
      end
  end
  
  
  def sign
      @event.update_attribute(:signed, true)
  end
  


  # DELETE /event_registrations/1
  # DELETE /event_registrations/1.json
  def destroy
    
    @registration = Registration.find(params[:id])
    @event = @registration.event
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
