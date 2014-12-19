
require 'uri'
require 'open-uri'
require 'json'
require 'net/https'
require 'net/http'
require 'addressable/uri'
require 'thor'
require 'rexml/document'

class Dic < Thor
	default_command :dic
	
	desc 'dic', 'how to use'
	def dic
		puts ''
		puts '	usage : dic  <subcommmand> <--options> [word]'
		puts ''
		puts 'subcommands :'
		puts '	je	japanese -> english'
		puts '	ej	english -> japanese'
		puts '	trans  translation by google api'
		puts ''
		puts 'options :'
		puts '	--je  your japanese sentence translation to english sentence by google api'
		puts '	--ej  your english sentence translation to japanese sentence by google api'
		puts ''
	end

	desc 'je', 'je'
	def je(word = "")
		search(word, 'japanese', 'english', 'EdictJE')
	end

	desc 'ej', 'je'
	def ej(*word)
		sentence = ""
		word.each do |w|
			sentence += w + "+"
		end
		search(sentence, 'english', 'japanese', 'EJdict')
	end
	
	desc 'trans', 'translation by google api'
	option :je, :type => :string, :desc => 'your japanese sentence translation to english sentence by google api'
	option :ej, :type => :string, :desc => 'your english sentence translation to japanese sentence by google api'
	def trans(*word)
		if options[:ej]
			sentence = options[:ej]
			word.each do |w|
				sentence += "+" + w 
			end
			trans_word(sentence, 'en', 'ja')
		else
			trans_word(options[:je], 'ja', 'en')
		end
	end
end

def search(word, from, to, dict) 
	uri = Addressable::URI.parse "http://public.dejizo.jp/NetDicV09.asmx/SearchDicItemLite?Dic=" + dict +  "&Word=" + word + "&Scope=HEADWORD&Match=STARTWITH&Merge=AND&Prof=XHTML&PageSize=10&PageIndex=0"
	res = Net::HTTP.get uri
	doc = REXML::Document.new res
	id = []
	title_en = []
	title_jp = []
	doc.elements.each('/SearchDicItemResult/TitleList/DicItemTitle') do |e| 
		id << e.elements['ItemID'].text
		title_en << e.elements['Title'].elements['span'].text
		url = URI.parse "http://public.dejizo.jp/NetDicV09.asmx/GetDicItemLite?Dic="+ dict +"&Item="+ e.elements['ItemID'].text + "&Loc=&Prof=XHTML"
		resu = Net::HTTP.get url
		docu = REXML::Document.new resu
		if dict == 'EJdict' 
			docu.elements.each('/GetDicItemResult/Body/div') {|e| title_jp << e.elements['div'].text }
		else
			docu.elements.each('/GetDicItemResult/Body/div/div') {|e| title_jp << e.elements['div'].text }
		end
	end
	puts '------------------------------------------------------------------------------------------------------------------------------------------'
	printf('%25s' + '%8s' + '%-75s', from, ' ', to)
	puts ''
	puts '------------------------------------------------------------------------------------------------------------------------------------------'
	if id.length == 0
		printf("%25s" + 'not found', ' ' )
		puts ''
	end
	for i in 0...id.length do
		printf('%25s' + '%8s' + '%-75s', title_en[i], ' ', title_jp[i][0...45]);
		puts ''
	end
	puts '------------------------------------------------------------------------------------------------------------------------------------------'
end

def trans_word(word, from, to)
	https = Net::HTTP.new('www.googleapis.com',443)
	https.use_ssl = true
	https.verify_mode = OpenSSL::SSL::VERIFY_NONE
	https.verify_depth = 5

	puts '------------------------------------------------------------------------------------------------------------------------------------------'
	printf('%25s' + '%8s' + '%-75s', from, ' ', to)
	puts ''
	puts '------------------------------------------------------------------------------------------------------------------------------------------'

	https.start {
	  response = https.get('/language/translate/v2?key=AIzaSyBCFuxk01XH39Tcw2C_7hUXlbFYmZ1hYjc&q=' + word  + '&source=' + from  +  '&target=' + to)
	  result = JSON.parse(response.body)
	  printf('%25s' + '%8s' + '%-75s', word, ' ', result['data']['translations'][0]['translatedText'] );

	  # puts result['data']['translations'][0]['translatedText']
	  puts ''
	}
	puts '------------------------------------------------------------------------------------------------------------------------------------------'
end

Dic.start
