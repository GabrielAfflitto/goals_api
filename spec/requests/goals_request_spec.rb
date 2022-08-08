RSpec.describe 'Goals', type: :request do
 # initialize test data
 let!(:goals) { create_list(:goal, 10) }
 let(:goal_id) { goals.first.id }
 describe 'GET /goals' do
   before { get '/api/v1/goals' }
   it 'returns goals' do
     expect(json).not_to be_empty
     expect(json.size).to eq(10)
   end
   it 'returns status code 200' do
     expect(response).to have_http_status(200)
   end
 end
 describe 'GET /goals/:id' do
   before { get "/api/v1/goals/#{goal_id}" }
   context 'when goal exists' do
     it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
     it 'returns the goal item' do
       expect(json['id']).to eq(goal_id)
     end
   end
   context 'when goal does not exist' do
     let(:goal_id) { 0 }
     it 'returns status code 404' do
       expect(response).to have_http_status(404)
     end
     it 'returns a not found message' do
       expect(response.body).to include("Couldn't find Book with 'id'=0")
     end
   end
 end
 describe 'POST /goals/:id' do
   let!(:history) { create(:category) }
   let(:valid_attributes) do
     { title: 'Whispers of Time', author: 'Dr. Krishna Saksena',
       category_id: history.id }
   end
   context 'when request attributes are valid' do
     before { post '/api/v1/goals', params: valid_attributes }
     it 'returns status code 201' do
       expect(response).to have_http_status(201)
     end
   end
   context 'when an invalid request' do
     before { post '/api/v1/goals', params: {} }
     it 'returns status code 422' do
       expect(response).to have_http_status(422)
     end
     it 'returns a failure message' do
       expect(response.body).to include("can't be blank")
     end
   end
 end
 describe 'PUT /goals/:id' do
   let(:valid_attributes) { { title: 'Saffron Swords' } }
   before { put "/api/v1/goals/#{goal_id}", params: valid_attributes }
   context 'when goal exists' do
     it 'returns status code 204' do
       expect(response).to have_http_status(204)
     end
     it 'updates the goal' do
       updated_item = Book.find(goal_id)
       expect(updated_item.title).to match(/Saffron Swords/)
     end
   end
   context 'when the goal does not exist' do
     let(:goal_id) { 0 }
     it 'returns status code 404' do
       expect(response).to have_http_status(404)
     end
     it 'returns a not found message' do
       expect(response.body).to include("Couldn't find Book with 'id'=0")
     end
   end
 end
 describe 'DELETE /goals/:id' do
   before { delete "/api/v1/goals/#{goal_id}" }
   it 'returns status code 204' do
     expect(response).to have_http_status(204)
   end
 end
end
