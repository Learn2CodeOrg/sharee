module API
  module V1
    class SellActionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        # Parameters
        link_id = params[:link]
        code = params[:code]
        email = params[:email]
        price = params[:price]

        # Check parameters
        unless link_id
          return render json: { 'Error' => 'Missing link ID!' }, status: 422
        end
        unless code
          return render json: { 'Error' => 'Missing payment ID!' }, status: 422
        end
        unless email
          return render json: { 'Error' => 'Missing email!' }, status: 422
        end
        unless price
          return render json: { 'Error' => 'Missing price!' }, status: 422
        end

        # Get link
        link = Link.where(id: link_id)

        # Check link
        unless link
          return render json: { 'Error' => 'Link not found!' }, status: 422
        end

        # Create SellAction
        sell_action = SellAction.getOrCreate(code, link_id, email, price)

        # COOL!
        return render json: { id: sell_action.id }, status: 201
      end
    end
  end
end