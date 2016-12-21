require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Suggestions' do
  get '/suggestions' do
    parameter :q, 'Querystring param for search terms by product name'
    parameter :max_price, 'Max product price limit'
    parameter :min_price, 'Min product price limit'
    parameter :cat, 'Category for product'

    example "Search suggested products" do
      explanation 'This method returns a JSON with products based on query params.'
      cat1 = FactoryGirl.create(:category)
      cat2 = FactoryGirl.create(:category)

      prod1 = FactoryGirl.create(:suggestion, category: cat1)
      prod2 = FactoryGirl.create(:suggestion, category: cat2)
      prod3 = FactoryGirl.create(:suggestion, category: cat1)
      prod4 = FactoryGirl.create(:suggestion, category: cat2)
      prod5 = FactoryGirl.create(:suggestion, category: cat1)
      prod6 = FactoryGirl.create(:suggestion, category: cat2)
      prod7 = FactoryGirl.create(:suggestion, category: cat1)
      prod8 = FactoryGirl.create(:suggestion, category: cat2)
      prod9 = FactoryGirl.create(:suggestion, category: cat1)
      prod10 = FactoryGirl.create(:suggestion, category: cat2)
      prod11 = FactoryGirl.create(:suggestion, category: cat1)

      do_request(q: 'a', min_price: 1, max_price: 500, cat: cat1.id)
      expect(status).to eq 200
    end
  end
end
