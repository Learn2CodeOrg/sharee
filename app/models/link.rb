class Link < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  has_many :open_actions
  has_many :sell_actions

  delegate :email, to: :user, prefix: true, allow_nil: true

  def self.get_by_code(code)
    Link.where(code: code).first
  end

  def user=(new_user)
    super(new_user)
    update_code
  end

  def campaign=(new_campaign)
    super(new_campaign)
    update_code
  end

  def url=(new_url)
    super(new_url)
    update_code
  end

  def special_url
    id.to_s
  end

  def update_code
    unless campaign && user && url
      return false
    end

    self.code = ShareeDigest.code(url, campaign.id, user.id)
  end
end
