require 'rails_helper'

RSpec.describe 'Posts API', type: :request do 
  let!(:posts) { create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  describe 'GET /posts' do 
    before { get '/posts' }

    it 'returns 10 posts' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /posts' do 
    let(:valid_attributes) { { title: 'foo', body: 'bar', topics_attributes: [ { name: 'baz' }, { name: 'qux' } ] } }

    context 'when the request is valid' do 
      before { post '/posts', params: valid_attributes }

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end

      it 'creates post record' do 
        expect(json).not_to be_empty
        expect(json['title']).to eq('foo')
        expect(json['topics'].size).to eq(2)
      end
    end

    context 'when the request is invalid' do 
      before { post '/posts' }

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do 
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'GET /posts/:id' do 
    before { get "/posts/#{post_id}" }

    context 'when the record exists' do 

      it 'returns the post' do 
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do 
      let(:post_id) { 111 }

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Post/)
      end

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /posts/:id' do 
    context 'when the record exists' do 
      before { put "/posts/#{post_id}", params: { title: 'modified' } }

      it 'updates the post' do 
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do 
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /posts/:id' do 
    before { delete "/posts/#{post_id}" }

    it 'deletes the post' do 
      expect(response.body).to be_empty
    end 

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end
  end
end