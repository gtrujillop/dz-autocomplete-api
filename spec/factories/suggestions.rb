FactoryGirl.define do
  factory :suggestion do
    name { Faker::Commerce.product_name }
    price { Faker::Number.decimal(2, 2) }
    image "image_url.jpg"
    category { Category.create(name: 'Dummy Category') }
  end
end
