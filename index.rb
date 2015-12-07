require 'sinatra'
require 'rest_client'
require 'dotenv'
require 'oauth2'
require 'pry'
Dotenv.load

def client_secret
  ENV['CLIENT_SECRET']
end

def client_id
  ENV['CLIENT_ID']
end

def client_redirect_uri
  ENV['CLIENT_REDIRECT_URI']
end

def auth_url
  "https://www.twitchalerts.com/api/v1.0/authorize"
end

def client
  @client ||= OAuth2::Client.new(client_id, client_secret, :site => auth_url)
end

configure do
  REDIS = Redis.new(url: ENV["REDIS_URL"])
end

get '/login' do
  redirect(
    to(
      client.auth_code.authorize_url(redirect_uri: client_redirect_uri)
    )
  )
end

post '/oauth/callback' do
  puts params
end

get '/credits' do
  # var = get_donations
  erb :credits
end

post '/monkey/say' do
  Messages.create(message: params[:message])
end
