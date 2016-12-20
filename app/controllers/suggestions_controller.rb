class SuggestionsController < ApplicationController

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.filter(params.slice(:q, :min_price, :max_price, :cat))
    render json: @suggestions, each_serializer: SuggestionSerializer
  end

  private

    def suggestion_params
      params.require(:suggestion).permit(:name, :price, :image, :category_id)
    end
end
