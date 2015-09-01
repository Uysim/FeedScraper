module Shared
  def create_agent(url)
    sleep Random.rand(9)+1
    agent = Mechanize.new
    agent.get(url)
    agent
  end

  def click_link(page,href)
    if href
      content_link = page.link_with(href: href)
      if content_link
        sleep Random.rand(9)+1
        content_page=content_link.click
      end
    end
  end
end