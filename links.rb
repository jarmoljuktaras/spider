require 'nokogiri'
require 'open-uri'
class Crawler
	attr_accessor :http, :file, :links, :used, :level
	
	def initialize http
		@http=http
		@links=Array.new
		@used=Array.new
		@links.push @http
		@level=level
		@i=0
	end

	def links_search level
		l=@links.size
		while @i<l
			page=Nokogiri::HTML(open(@links[@i])) if @links[@i] && !@used.include?(@links[@i]) 
			page.css('a').each do |link|
				if link['href'][0]=='/'
					@links.push @http+link['href']
				else
					@links.push link['href']
				end
			end
		@used.push @links[@i]
		@i+=1
		end
		links_search(level-1) unless level<=1 	
		@i=0
	end
	def write_to_file name
		@file=File.open(name,"w+")
		@links.each do |x|
			@file.write "[ "+x+" ]"
		end
	end
end


