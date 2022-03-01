# require libraries/modules here

require "nokogiri"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {} #returns a hash
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title] = { #project titles point to a hash of info
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value, #each proj has an image link
      :description => project.css("p.bbcard_blurb").text, #each proj has a description as a string
      :location => project.css("ul.project-meta span.location-name").text, #each proj has a location as a string
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i 
      #each proj has a percentage funded listed as an integer
    }
  end
  projects
end