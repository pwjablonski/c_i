class EventRegistrationsController < ApplicationController
#  before_action :set_event_registration, only: [:show, :edit, :update, :destroy]

  # POST /event_registrations
  # POST /event_registrations.json
  def create
      @event = Event.find(params[:event_id])
      attendees = @event.attendees
      
      @attendees.each do |attendee|
          if User.find_by(email: user_email).try(:student?)
              @student = User.find_by(email: user_email).student
              
              @event_registration = @event.add_student(@student)
              
              if @event_registration == nil
                  @notice = @notice + "#{user_email} already enrolled  "
                  else
                  @event_registration.save
                  @notice = @notice + "#{user_email} successfully enrolled  "
              end
              else
              @notice = @notice + "#{user_email} not found  "
          end
      end
      
      respond_to do |format|
          format.html {redirect_to classroom_path(@classroom),
              notice: @notice }
      end


    respond_to do |format|
      if @event_registration.save
        format.html { redirect_to @event_registration, notice: 'Event registration was successfully created.' }
        format.json { render :show, status: :created, location: @event_registration }
      else
        format.html { render :new }
        format.json { render json: @event_registration.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def sign
      
      @event.update_attribute(:signed, true)
  end
  


  # DELETE /event_registrations/1
  # DELETE /event_registrations/1.json
  def destroy
    @event_registration.destroy
    respond_to do |format|
      format.html { redirect_to event_registrations_url, notice: 'Event registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
