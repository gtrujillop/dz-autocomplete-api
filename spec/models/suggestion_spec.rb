require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  describe 'relations' do
    it { should belong_to(:category) }
  end

  describe 'named scopes' do

    before do
      category_1 = FactoryGirl.create(:category)
      category_2 = FactoryGirl.create(:category)
      @sg_1 = FactoryGirl.create(:suggestion, name: 'Dummy Name 1', category: category_1)
      @sg_2 = FactoryGirl.create(:suggestion, name: 'Dummy Name 2', category: category_2)
      @sg_3 = FactoryGirl.create(:suggestion, name: 'Dummy Name 3', category: category_2)
      @sg_4 = FactoryGirl.create(:suggestion, name: 'dummy name 4', category: category_1)
    end

    describe 'q' do
      context 'when do a querystring search with params' do
        it 'returns objects which name matches with search params' do
          results = Suggestion.q('1')
          expect(results).to eq([@sg_1])
        end
      end

      context 'when do a querystring search with params in lowercase' do
        it 'returns objects which name matches with search params' do
          results = Suggestion.q('d')
          expect(results).to eq([@sg_1, @sg_2, @sg_3, @sg_4])
        end
      end

      context 'when do a querystring search with params in uppercase' do
        it 'does not returns objects which name matches with search params' do
          results = Suggestion.q('D')
          expect(results).to_not include(@sg_1)
        end
      end
    end

    describe 'max_price' do
      context 'when a number is passed' do
        it 'returns objects which price is below param' do
          param = 120
          results = Suggestion.max_price(param)
          expect(results.first.price <= param).to be true
        end
      end
    end

    describe "min_price" do
      context 'when a number is passed' do
        it 'returns objects which price is over param' do
          param = 10
          results = Suggestion.min_price(param)
          expect(results.first.price >= param).to be true
        end
      end
    end

    describe "cat" do
      context 'when a category_id is passed' do
        it 'returns objects related to given category' do
          category_id = Category.first.id
          results = Suggestion.cat(category_id)
          expect(results).to eq([@sg_1, @sg_4])
        end
      end
    end
  end
end
