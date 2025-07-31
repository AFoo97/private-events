class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    EventAttendance.create(attendee_id: current_user.id, attended_event_id: params[:attended_event_id])
    redirect_to event_path(params[:attended_event_id])
  end

  def destroy
    attendance = EventAttendance.find_by(attendee_id: current_user.id, attended_event_id: params[:attended_event_id])
    attendance.destroy if attendance
    redirect_to event_path(params[:attended_event_id])
  end
end
