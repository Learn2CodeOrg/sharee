class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :campaigns
  has_many :links

  def self.get_or_create_by_email(email)
    user = User.where(email: email).first
    unless user
      user = User.new(email: email, password: 'password', password_confirmation: 'password')
      user.save!
    end
    user
  end
end
