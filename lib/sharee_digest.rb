class ShareeDigest
  def self.code(url, campaign_id, user_id)
    (Digest::SHA2.new << "#{url};#{campaign_id};#{user_id}").to_s
  end
end
