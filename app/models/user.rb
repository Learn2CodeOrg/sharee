class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async

  has_many :campaigns
  has_many :links

  enum role: { merchant: 0, referer: 1 }

  def self.get_or_create_by_email(email, role)
    user = User.where(email: email).first
    unless user
      user = User.invite!(email: email, role: role)
    end
    user
  end
end
