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
  monthly_budget: '0.00'
)

AdminUser.create(
  email: 'test1@example.com',
  password: 'password',
)

['Travel', 'Chores', 'Family services', 'Food delivery', 'Relax', 'Pet lovers', 'Education'].each do |c|
  ItemCategory.create(name: c, order: 1)
end

seed_services = [
  ['Uber', 'Travel', 'brings you everywhere'],
  ['Handy', 'Chores', 'amazing service'],
  ['Washio', 'Chores', 'wash stuff?'],
  ['Instacart', 'Chores', 'cmon, it is insta'],
  ['ClassPass', 'Relax', 'relax at a glance'],
  ['Stylebee', 'Relax', 'so cool'],
  ['Manicube', 'Relax', 'manicure! cheap'],
  ['OneMonth', 'Education', 'learning platform'],
  ['Udemy', 'Education', 'self esplicative'],
  ['DayOne', 'Education', 'learn and play!']
]

seed_services.each do |k,v, d|
  item = Item.create(
    name: k,
    min_credit: 25,
    max_credit: 100,
    item_category_id: ItemCategory.where(name: v).first.id,
    description: d,
    amount_save: 0
  )

  item.image = File.open("../workful_images/#{k}.jpg", 'rb')
  item.save
end

