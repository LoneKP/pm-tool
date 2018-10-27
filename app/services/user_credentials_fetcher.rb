require 'httparty'

include HTTParty

class HarvestAuth

	#	base_uri "https://id.getharvest.com/api/v2/accounts"
	#
	#	def initialize(ct,token,options)
	#
	#		self.class.headers 'Content-type' =>  "#{ct}"
	#
	#		self.class.headers 'x-dnb-user' => "#{token}"
	#
	#		self.class.headers 'x-dnb-pwd'=> "#{options}"
	#
	#	end
	#
	#	def token()
	#		response = self.class.post("/")
	#	end

	response = HTTParty.get('http://localhost:3000', follow_redirects: false)

	if response.code >= 300 && response.code < 400
		redirect_url = response.headers['location']
		puts 'harvestauth class is working'
	end

end