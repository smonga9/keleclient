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
        @user_data = JSON.parse((self.class.get('/users/me', headers: {"authorization" => @authtoken})).body)
    end

    def get_mentor_availability(mentor_id)
      response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token})
      @mentor_availability = JSON.parse(response.body)
      p @mentor_availability
    end
end
