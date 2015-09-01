class Category < ActiveRecord::Base
  has_many :contents, as: :contentable, dependent: :destroy
  belongs_to :website

  def fetch_content(home_page_agent)
    sleep Random.rand(9)+1
    type_page = home_page_agent.page.link_with(text: name, href: link_url).click
    website.get_selector(:content_link).each do |content_link_selector|
      type_contents = type_page.search content_link_selector
      type_contents.each do |type_content|
        begin
        if type_content.attributes["href"]
          content_page = click_link type_page, type_content.attributes["href"].value
          content_page.parser.css("body article#article-body span.credit").try(:remove)
          if content_page

            title = content_page.search website.get_selector(:content_title).first
            imgs=[]
            website.get_selector(:content_image).each do |image_selector|
              imgs =  imgs.concat content_page.search(image_selector)
            end
            bodies=[]
            website.get_selector(:content_body).each do |body_selector|
              bodies = bodies.concat content_page.search(body_selector)
            end
            create_content(title,imgs,bodies,content_page.uri.path)
          end
        end
        rescue => e
          puts "caught exception #{e}! ohnoes!"
        end
      end
    end
  end

  def create_content(title,imgs,bodies,content_page_uri)
    if bodies.any?
      content = contents.where(title: title.text, link_url: content_page_uri)
      unless content.any?
        content = contents.create(title: title.text, link_url: content_page_uri)
        content.create_content_images(imgs)
        content.create_content_bodies(bodies)
      end
    end
  end
end
