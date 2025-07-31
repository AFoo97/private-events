class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendances, source: :attendee

  has_many :invitations
  has_many :invited_users, through: :invitations, source: :user

  scope :past, -> { where('date < ?', Time.now) }
  scope :upcoming, -> { where('date >= ?', Time.now) }
  
end
