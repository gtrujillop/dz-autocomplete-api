class SuggestionsController < ApplicationController

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.filter(params.slice(:q, :min_price, :max_price, :cat))
    render json: @suggestions, each_serializer: SuggestionSerializer
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      render json: @suggestion, status: :ok
    else
      render json: { errors: @suggestion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /suggestions/:id
  def update
    @suggestion = Suggestion.where(id: params[:id]).first
    unless @suggestion.present?
      render json: { errors: "suggestion not found with id #{params[:id]}" }, status: :not_found
      return
    end
    if @suggestion.update_attributes(suggestion_params)
      render json: @suggestion, status: :ok
    else
      render json: { errors: @suggestion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /suggestions/:id
  def destroy
    @suggestion = Suggestion.where(id: params[:id]).first
    unless @suggestion.present?
      render json: { errors: "suggestion not found with id #{params[:id]}" }, status: :not_found
      return
    end
    if @suggestion.destroy
      render json: @suggestion, status: :ok
    else
      render json: { errors: @suggestion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def suggestion_params
      params.require(:suggestion).permit(:name, :price, :image, :category_id)
    end
end
