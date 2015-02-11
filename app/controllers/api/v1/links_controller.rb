module API
  module V1
    class LinksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        # Get parameters
        campaign_id = params[:campaign]
        url = params[:url]
        email = params[:email]

        # Check parameters
        unless campaign_id
          return render json: { 'Error' => 'Missing campaign id!' }, status: 422
        end
        unless url
          return render json: { 'Error' => 'Missing url!' }, status: 422
        end
        unless email
          return render json: { 'Error' => 'Missing email!' }, status: 422
        end

        # Get campaign
        campaign = Campaign.find(campaign_id)

        # Check campaign
        unless campaign
          return render json: { 'Error' => 'Campaign not found!' }, status: 422
        end

        # Get user
        user = User.get_or_create_by_email(email)

        # Check user
        unless user
          return render json: { 'Error' => 'Problem with user!' }, status: 422
        end

        # Make new link
        link = Link.new(campaign: campaign, user: user, url: url)

        # Get existing link or save new one
        existing_link = Link.get_by_code(link.code)
        if existing_link
          link = existing_link
        else
          link.save!
        end

        # COOL!
        return render json: { id: link.id, url: link.url, special_url: 'http://' + request.host_with_port + '/' + link.special_url }, status: 201
      end
    end
  end
end
