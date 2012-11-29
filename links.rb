require 'nokogiri'
require 'open-uri'
def linksSearch http,number
	file=File.open("text.txt","w+")
	mas=Array.new
	mas.push http
	n=number
	i=0
	while n!=0
		l=mas.size
		while i<l
			page=Nokogiri::HTML(open(mas[i])) if mas[i]
			page.css('a').each do |link|
				if link['href'][0]=='/'
					mas.push http+link['href']
				else
					mas.push link['href']
				end
			end
		i+=1
		end
		n-=1
	end
	mas.each do |x|
		file.write "[ "+x+" ]"
	end
end
http,number= ARGV
number=number.to_i
linksSearch(http,number)


