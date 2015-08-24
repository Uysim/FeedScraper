class Category < ActiveRecord::Base
  has_many :contents
  belongs_to :website

  def fetch_content(home_page_agent)
    sleep 3
    type_page = home_page_agent.page.link_with(text: name, href: link_url).click
    type_page_agent = create_agent type_page.uri
    type_contents = type_page.search website.get_selector(:content_link)
    type_contents.each do |type_content|
      begin
      if type_content.attributes["href"]
        content_page = click_link type_page_agent, type_content.attributes["href"].value
        if content_page
          title = content_page.search website.get_selector(:content_title)
          imgs = content_page.search website.get_selector(:content_image)
          bodies = content_page.search website.get_selector(:content_body)
          create_content(title,imgs,bodies,content_page.uri)
        end
      end
      rescue => e
        puts "caught exception #{e}! ohnoes!"
      end
    end
  end

  def create_content(title,imgs,bodies,content_page_uri)
    content = contents.where(title: title.text, link_url: content_page_uri)
    unless content.any?
      content = contents.create(title: title.text, link_url: content_page_uri)
      content.create_content_images(imgs)
      content.create_content_bodies(bodies)
    end

  end
end
