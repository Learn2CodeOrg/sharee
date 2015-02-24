# Reset

User.delete_all
Campaign.delete_all
Link.delete_all
OpenAction.delete_all
SellAction.delete_all


# Create users

user1 = User.create!(
  email: 'merchant@sharee.io',
  password: 'password',
  password_confirmation: 'password',

  iban_merchant: 'SK11 1111 1111 1111 1111 1111',
  swift_merchant: 'SK1111',
  paypal_merchant: 'mail-1111@paypal.com',

  iban_referer: 'SK00 0000 0000 0000 0000 0000',
  swift_referer: 'SK0000',
  paypal_referer: 'mail-0000@paypal.com',
)
user2 = User.create!(
  email: 'referer@sharee.io',
  password: 'password',
  password_confirmation: 'password',

  iban_referer: 'SK22 2222 2222 2222 2222 2222',
  swift_referer: 'SK2222',
  paypal_referer: 'mail-2222@paypal.com',

  iban_merchant: 'SK00 0000 0000 0000 0000 0000',
  swift_merchant: 'SK0000',
  paypal_merchant: 'mail-0000@paypal.com',
  role: :referer
)


# Create campaigns

campaign1 = Campaign.create!(user: user1, name: 'DSL',       url: 'http://www.dsl.sk',       commission: '10')
campaign2 = Campaign.create!(user: user1, name: 'Wikipedia', url: 'http://www.wikipedia.sk', commission: '15')
campaign3 = Campaign.create!(user: user1, name: 'Mojevideo', url: 'http://www.mojevideo.sk', commission: '15')
campaign4 = Campaign.create!(user: user1, name: 'Localhost', url: 'http://localhost:3000',   commission: '20')
campaign5 = Campaign.create!(user: user1, name: 'Rebelik',   url: 'http://webrebel.sk',      commission: '20')


# Create links

[campaign1, campaign2, campaign3, campaign4, campaign5].each do |campaign|
  (1..60).each do |number|

    link = Link.create!(campaign: campaign, user: user2, url: "#{campaign.url}/article.php?article=#{number}")

    if (number % 2 == 0)
      OpenAction.create!(link: link)
    end

    if (number % 4 == 0)
      sell_action = SellAction.getOrCreate("sell_#{link.id}_#{number}", link, 'buyer@sharee.io', rand(50..300))

      if (number % 8 == 0)
        sell_action.approved_at = nil
      end

      sell_action.save!
    end
  end
end
