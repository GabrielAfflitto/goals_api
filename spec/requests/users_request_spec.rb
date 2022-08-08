RSpec.describe 'Users', type: :request do
 # initialize test data
 let!(:users) { create_list(:user, 5) }
 let!(:user_id) { users.first.id }



 # Test suite for GET /user
 describe 'GET /users' do
   # make HTTP get request before each example
   before { get '/api/v1/users' }
   it 'returns users' do
     expect(json).not_to be_empty
     expect(json.size).to eq(5)
   end
   it 'returns status code 200' do
     expect(response).to have_http_status(200)
   end
 end
 # Test suite for POST /users
 describe 'POST /users' do
   # valid payload
   let(:user_params) { { name: 'Jim', email: 'jimbo12@gmail.com', password: 'hellohello23' } }
   context 'when the request is valid' do
     before { post '/api/v1/users', params: user_params }
     it 'creates a user' do
       expect(json['name']).to eq('Jim')
     end
     it 'returns status code 201' do
       expect(response).to have_http_status(201)
     end
   end
   context 'when the request is invalid' do
     before { post '/api/v1/users', params: { name: '' } }
     it 'returns status code 422' do
       expect(response).to have_http_status(422)
     end
     it 'returns a validation failure message' do
       expect(response.body)
      .to include("is too short (minimum is 3 characters)")
     end
   end
 end
 # Test suite for DELETE /user/:id
 describe 'DELETE /users/:id' do
   before { delete "/api/v1/users/#{user_id}" }
   it 'returns status code 204' do
     expect(response).to have_http_status(204)
   end
 end
end
