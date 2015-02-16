class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :links

  def zero_based_commission
    commission / 100
  end
end
