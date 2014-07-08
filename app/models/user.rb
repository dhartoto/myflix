class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :password, on: :create, length: { minimum: 8 }, confirmation: true
  validates_presence_of :username, :full_name, :email, :password, :password_confirmation
  validates_uniqueness_of :email, :username

  has_many :reviews
  has_many :queue_videos, -> {order(:position)}

  def normalise_queue_positions
    queue_videos.each_with_index do |position, index|
      position.update(position: index + 1)
    end
  end
end
