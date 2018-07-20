class ReviewsController < ApplicationController
    def create
        @review = Review.new(review_params)
        if @review.save
            redirect_to :back
        else
            render :back
        end
    end

    private
    def review_params
        p "---------"
        description_rating_hash =  params.require(:review).permit(:description, :rating)
        product_id_hash = { "product_id" => params[:product_id] }
        user_id_hash = {"user_id" => current_user.id } 
        description_rating_hash.merge(product_id_hash).merge(user_id_hash)
    end
end
