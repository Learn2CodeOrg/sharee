# Reset

User.delete_all
Campaign.delete_all
Link.delete_all
OpenAction.delete_all
SellAction.delete_all


# Create users

user1 = User.create!(email: 'janko@example.com', password: 'password', password_confirmation: 'password')
user2 = User.create!(email: 'marienka@example.com', password: 'password', password_confirmation: 'password')
user3 = User.create!(email: 'jozefina@example.com', password: 'password', password_confirmation: 'password')


# Create campaign

campaign1 = Campaign.create!(user: user1, name: 'DSL', url: 'www.dsl.sk')
campaign2 = Campaign.create!(user: user1, name: 'Wikipedia', url: 'www.wikipedia.sk')
campaign3 = Campaign.create!(user: user1, name: 'Mojevideo', url: 'www.mojevideo.sk')
campaign4 = Campaign.create!(user: user1, name: 'Localhost', url: 'localhost:3000')


# Create sharing link

link1 = Link.create!(campaign: campaign1, user: user2, url: 'http://dsl.sk/article.php?article=16634')
link2 = Link.create!(campaign: campaign1, user: user3, url: 'http://www.dsl.sk/article.php?article=16616')


# Create open actions

OpenAction.create!(link: link1)
OpenAction.create!(link: link1)
OpenAction.create!(link: link1)
OpenAction.create!(link: link1)

OpenAction.create!(link: link2)
OpenAction.create!(link: link2)


# Create sell action

SellAction.create!(link: link1, code: '001', email: 'spokojny@gmail.com', price: '125')
SellAction.create!(link: link2, code: '002', email: 'velmispokojny@gmail.com', price: '105')
