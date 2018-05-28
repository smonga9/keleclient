require 'httparty'

require 'json'

class Kele
  include HTTParty
    base_uri 'https://www.bloc.io/api/v1'
    include JSON

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

    def get_me
        JSON.parse((self.class.get('/users/me', headers: {"authorization" => @authtoken})).body)
    end
end
