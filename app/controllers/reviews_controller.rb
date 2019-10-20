class ReviewsController < ApplicationController
  before_action :authorize_user, only: :create
  before_action :authorize_owner, only: :reply
  before_action :authorize_admin, only: %i[update destroy]
  before_action :set_review, only: %i[show update destroy reply]

  # GET /reviews
  def index
    @reviews = Review.where(query_params).page(page).per(per_page)

    render json: serialize('Review', @reviews)
  end

  # GET /reviews/1
  def show
    render json: serialize('Review', @review)
  end

  # POST /reviews
  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      render json: serialize('Review', @review), status: :created
    else
      render json: ame_serialize(@review.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(attributes.permit(:comment))
      render json: serialize('Review', @review)
    else
      render json: ame_serialize(@review.errors), status: :unprocessable_entity
    end
  end

  def reply
    if @review.update(attributes.permit(:reply))
      render json: serialize('Review', @review)
    else
      render json: ame_serialize(@review.errors), status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private

  def query_params
    queries.permit(:store_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def review_params
    attributes.permit(:rate, :comment, :date).merge(
      relationships_to_params(relationships.permit(store: {}).to_h)
    )
  end
end
