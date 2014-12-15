require 'open-uri'
require 'net/https'
require 'json'
require 'thor'

class Trans < Thor
	default_command :trans

	desc 'trans', 'how to use'
	def trans
		puts ''
		puts '    usage : trans <subcommand> [word]'
		puts ''
		puts 'subcommands : '
		puts '	ja	japanese -> english'
		puts '	en	english -> japanese'
		puts ''
	end
	
	desc 'ja', 'translate into english'
	def ja(word="")
		trans_word(word, 'ja', 'en')
	end
	
	desc 'en', 'translate into japanese'
	def en(word = "")
		trans_word(word, 'en', 'ja')
	end
end

def trans_word(word, from, to)
	https = Net::HTTP.new('www.googleapis.com',443)
	https.use_ssl = true
	https.verify_mode = OpenSSL::SSL::VERIFY_NONE
	https.verify_depth = 5

	https.start {
	  response = https.get('/language/translate/v2?key=AIzaSyBCFuxk01XH39Tcw2C_7hUXlbFYmZ1hYjc&q=' + word  + '&source=' + from  +  '&target=' + to)
	  result = JSON.parse(response.body)
	  str =  result['data']['translations']
	  puts str[0]['translatedText']
	  puts ''
	}
end
Trans.start
