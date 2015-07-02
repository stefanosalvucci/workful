company = Company.create(
  name: "example",
  domain: "example.com",
  monthly_budget: 200,
  done_welcome: false,
)

company.users.create(
  email: 'test1@example.com',
  password: 'password',
  first_name: 'Test',
  last_name: 'Example',
  monthly_budget: 200.0
)

AdminUser.create(
  email: 'test1@example.com',
  password: 'password',
)

['Travel', 'Chores', 'Family services', 'Food delivery', 'Relax', 'Pet lovers', 'Education'].each do |c|
  ItemCategory.create(name: c, order: 1)
end

seed_services = [
  ['Uber', 'Travel', 'brings you everywhere', 'http://the305.com/blog/wp-content/uploads/2014/06/uber-logo.jpg'],
  ['Handy', 'Chores', 'amazing service', 'http://core0.staticworld.net/images/article/2014/09/handy_logo-100435695-large.jpg'],
  ['Washio', 'Chores', 'wash stuff?', 'https://d1qb2nb5cznatu.cloudfront.net/startups/i/138210-90726fa7f6e3a5aa532d50ffba5dc671-medium_jpg.jpg?buster=1375820899'],
  ['Instacart', 'Chores', 'cmon, it is insta', 'http://www.glutenfreebostongirl.com/wp-content/uploads/2014/04/Instacart-Logo-Green-Transparent-1024x299.png'],
  ['ClassPass', 'Relax', 'relax at a glance', 'http://www.mamachallenge.com/wp-content/uploads/2015/01/CDWN11-e1422601940511.png'],
  ['Stylebee', 'Relax', 'so cool', 'http://www.movingbrands.com/wp-content/uploads/2014/07/MovingBrands_StyleBee_StoryFeature_388.jpg'],
  ['Manicube', 'Relax', 'manicure! cheap', 'https://d1qb2nb5cznatu.cloudfront.net/startups/i/98033-d1134b10ba13edec45570fb92f22dfca-medium_jpg.jpg?buster=1386004954'],
  ['OneMonth', 'Education', 'learning platform', 'http://thisissmoorelovin.com/images/logos-clients/ClientLogos_OneMonth.jpg'],
  ['Udemy', 'Education', 'self esplicative', 'https://d3q6qq2zt8nhwv.cloudfront.net/platform/ad60099634084625bb7f3b0331222195.png'],
  ['DayOne', 'Education', 'learn and play!', 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b6/Day_One_Logo.svg/1024px-Day_One_Logo.svg.png']
]

seed_services.each do |k,v, d, i|
  item = Item.create(
    name: k,
    min_credit: 25,
    max_credit: 100,
    item_category_id: ItemCategory.where(name: v).first.id,
    description: d,
    amount_save: 0
  )

  item.image = URI.parse(i)
  item.save
end

