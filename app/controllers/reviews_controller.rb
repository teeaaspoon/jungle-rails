class ReviewsController < ApplicationController
    before_filter :login_required
    def create
        @review = Review.new(review_params)
        if @review.save
            redirect_to :back
        else
            redirect_to :back
        end
    end

    def destroy
        @review = Review.find params[:review_id]
        @product = @review.product
        @review.destroy
        redirect_to product_path(@product)
    end

    private
    def review_params
        description_rating_hash =  params.require(:review).permit(:description, :rating)
        product_id_hash = { "product_id" => params[:product_id] }
        user_id_hash = {"user_id" => current_user.id } 
        description_rating_hash.merge(product_id_hash).merge(user_id_hash)
    end
    def login_required
        redirect_to login_path unless current_user.present?
    end
end
