require 'rails_helper'

RSpec.describe 'POST /api/v1/sell_actions', type: :request do

  context 'when sending empty request' do
    it 'returns 422 with message' do
      post '/api/v1/sell_actions'
      expect(response.status).to be 422
      message = JSON.parse(response.body)
      expect(message['Error']).to eq 'Missing link ID!'
    end
  end

  context 'when sending request with correct parameters' do
    it 'returns 201 with message' do
      FactoryGirl.create(:link)
      data = { link: 1, code: 'dvjn1515', email: 'lenka@vesela.sk', price: 250 }

      expect(SellAction.count).to be 0
      post '/api/v1/sell_actions', data
      expect(SellAction.count).to be 1
      expect(response.status).to be 201

      message = JSON.parse(response.body)
      last_sell_action = SellAction.last

      expect(message['id']).to eq last_sell_action.id
      expect(last_sell_action.link.id).to eq data[:link]
      expect(last_sell_action.code).to eq data[:code]
      expect(last_sell_action.email).to eq data[:email]
      expect(last_sell_action.price).to eq data[:price]
    end
  end
end
