class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :links
  has_many :open_actions, through: :links
  has_many :sell_actions, through: :links
end
