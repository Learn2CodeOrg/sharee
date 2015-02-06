class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :links

  def self.find_first_by_host(host)
    Campaign.where('url LIKE :url', { url: "%#{host}%"}).first
  end
end
