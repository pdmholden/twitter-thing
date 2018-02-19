require 'rails_helper'

describe 'CokeService' do
  let(:service) { CokeService.new }
  let(:url) { "https://devtestapiapp.herokuapp.com/" }

  describe '#get_latest' do
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
  end
end
