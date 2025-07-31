class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @past_events = Event.past.where(private: false)
    @upcoming_events = Event.upcoming.where(private: false)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event , notice: "Event created successfully."
    else
      render :new
    end
  end

  def show
    if @event.private && !@event.invited_users.include?(current_user) && @event.creator != current_user
      redirect_to root_path, alert: "You are not invited to this event."
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: "Event deleted."
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date, :private, :description, invited_user_ids: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless @event.creator == current_user
  end
end
