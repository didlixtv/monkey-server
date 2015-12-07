require 'sinatra'
require 'rest_client'
require 'dotenv'
require 'oauth2'
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

def client
  @client ||= OAuth2::Client.new('client_id', 'client_secret', :site => 'https://twitchalerts.com')
end

def do_stuff
  client.auth_code.authorize_url(:redirect_uri => client_redirect_uri)
  token = client.auth_code.get_token(
    'authorization_code_value',
    :redirect_uri => client_redirect_uri,
    :headers => {'Authorization' => 'Basic some_password'}
  )

  response = token.get('/api/v1.0/donations', :params => { 'query_foo' => 'bar' })
  response.class.name
end

get '/credits' do
  erb :credits
end
