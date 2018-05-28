require 'httparty'

class Kele
  include HTTParty
    format :json
    base_uri 'https://www.bloc.io/api/v1'

    attr_accessor :url, :authtoken

    def initialize(email, password)
        @url = 'https://www.bloc.io/api/v1'
        @authtoken = self.sign_in(email, password)
     end

     def sign_in(email, password)
        @authtoken = self.class.post('/sessions', :query => {email: email, password: password})["auth_token"]
        raise "Invalid login" if @authtoken.nil?
        @authtoken
    end
end
