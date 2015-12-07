require 'rest_client'

data = {
		message: "test"
}

puts RestClient.post("http://0.0.0.0:4567/monkey/say", data)
