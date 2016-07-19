class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable

  has_many :campaigns
  has_many :links
  has_one :billing_info

  accepts_nested_attributes_for :billing_info

  enum role: { merchant: 0, referer: 1 }

  def self.get_or_create_by_email(email, role)
    user = User.where(email: email).first
    unless user
      user = User.invite!(email: email, role: role)
    end
    user
  end

  after_initialize do |user|
    if user.merchant? && user.billing_info.blank?
      user.billing_info = BillingInfo.create!
    end
  end
end
