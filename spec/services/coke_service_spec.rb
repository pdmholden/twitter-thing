require 'rails_helper'

describe 'CokeService' do
  let(:service) { CokeService.new }
  let(:url) { "https://devtestapiapp.herokuapp.com/" }

  describe '#get_latest' do
    describe 'when there is an array of tweets' do
      let(:body) do
        "[{\"created_at\":\"2012-09-27T16:16:46Z\",\"followers\":23,\"id\":11,\"message\":\"Urgh - coke!\",\"sentiment\":-0.7,\"updated_at\":\"2012-09-27T16:16:46Z\",\"user_handle\":\"@coke_h8r\"},{\"created_at\":\"2012-09-27T16:18:09Z\",\"followers\":3,\"id\":13,\"message\":\"I've got to say - Pepsi max is great!\",\"sentiment\":0.9,\"updated_at\":\"2012-09-27T16:18:09Z\",\"user_handle\":\"@tasteless\"}]"
      end

      before do
       stub_request(:get, CokeService::ENDPOINT).
         with(  headers: {
          'Connection'=>'close',
          'Host'=>'devtestapiapp.herokuapp.com',
          'User-Agent'=>'http.rb/3.0.0'
           }).
         to_return(status: 200, body: body, headers: {})
      end

      it 'inserts items into the DB' do
        expect(Tweet).to receive(:create).twice
        service.get_latest
      end
    end
  end

  describe '#service_error' do
    describe 'when there is an array of tweets' do
      before do
       stub_request(:get, url).
         with(  headers: {
          'Connection'=>'close',
          'Host'=>'devtestapiapp.herokuapp.com',
          'User-Agent'=>'http.rb/3.0.0'
           }).
         to_return(status: 200, body: "[ {\"foo\" : \"bar\"}]", headers: {})

        service.resource = HTTP.get(url)
      end

      it 'returns false' do
        expect(service.service_error?).to be false
      end
    end

    describe 'when there is an error message' do
      before do
       stub_request(:get, url).
         with(  headers: {
          'Connection'=>'close',
          'Host'=>'devtestapiapp.herokuapp.com',
          'User-Agent'=>'http.rb/3.0.0'
           }).
         to_return(status: 200, body: "{\"error\" : \"blah\"}", headers: {})

        service.resource = HTTP.get(url)
      end

      it 'returns true' do
        expect(service.service_error?).to be true
      end
    end
  end
end
