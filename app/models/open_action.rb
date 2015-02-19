class OpenAction < ActiveRecord::Base
  belongs_to :link

  def self.count_links(links)
    OpenAction.where(link_id: links).count
  end
end
