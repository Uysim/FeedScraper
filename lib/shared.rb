module Shared
  def create_agent(url)
    agent = Mechanize.new
    agent.get(url)
    agent
  end

  def click_link(page,href)
    if href
      content_link = page.page.link_with(href: href)
      if content_link
        content_page=content_link.click
      end
    end
  end
end