require 'rails_helper'

RSpec.describe 'POST /api/v1/links', type: :request do

  context 'when sending empty request' do
    it 'returns 422 with message' do
      post '/api/v1/links'
      expect(response.status).to be 422
      message = JSON.parse(response.body)
      expect(message['Error']).to eq 'Missing campaign id!'
    end
  end

  context 'when sending request with correct parameters' do
    it 'returns 201 with message' do
      FactoryGirl.create(:campaign)
      data = { campaign: 1, url: 'www.dsl.sk/clanok-12345', email: 'janko@hrasko.sk' }

      expect(Link.count).to be 0
      post '/api/v1/links', data
      expect(Link.count).to be 1
      expect(response.status).to be 201

      message = JSON.parse(response.body)
      last_link = Link.last

      expect(message['id']).to eq last_link.id
      expect(message['url']).to eq last_link.url
      expect(message['special_url']).to eq last_link.special_url
    end
  end
end
