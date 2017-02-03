class SuggestionsSearchController < ApplicationController
  def search
    criteria = params.slice(:q, :max_price, :min_price, :cat)
    if criteria.blank?
      @suggestions = []
    else
      @suggestions = Suggestion.search(criteria).records
    end
    render json: @suggestions, each_serializer: SuggestionSerializer
  end
end
