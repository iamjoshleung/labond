require 'rails_helper'

describe 'Topic API', type: :request do 
  let!(:topics) { create_list(:topic_with_posts, 10) }
  let!(:topic_id) { topics.first.id }
  let!(:invalid_topic_id) { 100 }

  describe 'GET /topics' do 
    before { get '/topics' }

    it 'returns 10 topics' do 
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /topics/:id' do 
    context 'when the record exists' do 
      before { get "/topics/#{topic_id}" }

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end

      it 'returns the record' do 
        expect(response.body).not_to be_empty
        expect(json['id']).to eq(topic_id)
      end
    end

    context 'when the record does not exist' do 
      before { get "/topics/#{invalid_topic_id}" }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        expect(json["message"]).to match(/Couldn't find Topic/)
      end
    end
  end

  describe 'POST /topics' do 
    context 'when the request is valid' do 
      let(:valid_attributes) { { name: 'fooo' } }
      before { post '/topics', params: valid_attributes }

      it 'returns the record' do 
        expect(json['name']).to eq('fooo')
      end

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do 
      before { post '/topics', params: {} }

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do 
        expect(json["message"]).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /topics/:id' do 
    context 'when the record exists' do 
      before { put "/topics/#{topic_id}", params: { name: 'foo_modified' } }

      it 'updates the record' do 
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do 
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do 
      before { put "/topics/#{invalid_topic_id}", params: { name: 'foo_modified' } }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do 
        expect(json['message']).to match(/Couldn't find Topic/)
      end
    end
  end

  describe 'DELETE /topics/:id' do 
    before { delete "/topics/#{topic_id}" }

    it 'deletes the record' do 
      expect(response.body).to be_empty
    end

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end
  end
end