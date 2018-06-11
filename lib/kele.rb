require 'httparty'
require 'json'
require './lib/roadmap.rb'

 class Kele
   include HTTParty
  include Roadmap
  base_uri = 'https://www.bloc.io/api/v1'

   def initialize(email, password)
     options = { body: { email: email, password: password } }
     response = self.class.post(api_url("sessions"), options)
     raise "Invalid email or password" if response.code == 404
     @auth_token = response["auth_token"]
   end

   def get_me
     response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token})
    @user = JSON.parse(response.body)
    @enrollment_id = @user["current_enrollment"]["id"]
   end

   def get_mentor_availability(mentor_id)
     response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token})
     @mentor_availability = JSON.parse(response.body)
     p @mentor_availability
   end

   def get_messages(page = nil)
      if page == nil
        response = self.class.get(api_endpoint("message_threads"), headers: { "authorization" => @auth_token})
      else
        response = self.class.get(api_endpoint("message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
      end
      puts response.code
      puts @messages = JSON.parse(response.body)
   end

    def create_message(recipient_id, subject, stripped_text)
      self.get_me if self.user == nil
      response = self.class.post(api_endpoint("messages"), body: { "sender": self.user["email"], "recipient_id": recipient_id, "subject": subject, "stripped-text": stripped_text }, headers: {"authorization" => @auth_token })
      puts response.code
    end

   private
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end
 end
