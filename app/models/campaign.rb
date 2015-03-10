class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :links
  has_many :open_actions, through: :links
  has_many :sell_actions, through: :links
  
  validates :name, presence: true
  validates :url, presence: true
  validates :commission, presence: true, numericality: { greater_than: 0, less_than: 100 }
  
  enum lang: {
    en: 0,
    sk: 1,
    cz: 2
  }
end
