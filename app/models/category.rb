class Category < ActiveRecord::Base
  has_many :contents, as: :contentable, dependent: :destroy
  belongs_to :website

  def fetch_content(selectors,home_page_agent,lim)
    sleep Random.rand(9)+1
    type_page = home_page_agent.page.link_with(text: name, href: link_url).try(:click)
    if type_page
      selectors[:list_selectors][:parent].each do |content_link_selector|
        type_page.search(content_link_selector).take(lim).each do |type_content|
          to_content_page(type_page,selectors,{
            thumnail: get_item_from_list(selectors[:list_selectors][:thumnail],type_content),
            snippet: get_item_from_list(selectors[:list_selectors][:snippet],type_content),
            link_content: get_item_from_list(selectors[:list_selectors][:link_element],type_content)
          })
        end
      end
    end

  end

  def to_content_page(type_page,selectors,list_element={})
    if list_element[:link_content] && list_element[:link_content].attributes['href']
      content_page = click_link(type_page, list_element[:link_content].attributes["href"].value)
      if content_page
        remove_element(selectors[:remove_selectors][:content_page],content_page)
        title_element = get_item_from_list(selectors[:content_selectors][:title],content_page)
        datarables=fetch_datarable(selectors,content_page)
        if title_element && list_element[:thumnail]
          creat_content(datarables,title_element.try(:text),list_element[:thumnail].attributes["src"].value,list_element[:snippet].try(:text),content_page.uri.path,selectors[:data_selectors])
        end

      end
    end
  end

  def get_item_from_list(selectors,type_content)
    selectors.each do |selector|
      element = type_content.search(selector).first
      if element
        return element
      end
    end
    nil
  end


  def fetch_datarable(selectors,content_page)
    datarables=[]
    selectors[:content_selectors][:parent].each do |parent_selector|
      content_page.search(parent_selector).each do |parent_element|
        datarables = datarables.concat(parent_element.search('*').select{ |e| check_element(selectors[:data_selectors],e) })
      end
    end
    datarables
  end

  def remove_element(selectors,content_page)
    selectors.each do |selector|
      content_page.parser.css(selector).try(:remove)
    end
    content_page.parser.css("script").try(:remove)
    content_page.parser.css("ins").try(:remove)
  end

  def creat_content(datarables,title,thumnail,snippet,content_page_url,data_selectors)
    if datarables.any? && !title.blank? && !contents.where(title: title, link_url: content_page_url).any?
      content = contents.create(title: title, link_url: content_page_url,thumnail: thumnail, snippet: snippet)
      datarables.each do |datarable|
        if data_selectors[:para].map { |e| e[:element][:name] }.include?(datarable.name.downcase) && !datarable.text.blank?
          body = Body.create(text: datarable.text.strip)
          content.content_references.create(datarable: body)
        elsif data_selectors[:image].map { |e| e[:element][:name] }.include?(datarable.name.downcase) && !datarable.attributes["src"].blank?
          img = Image.create(link_url: datarable.attributes["src"])
          content.content_references.create(datarable: img)
        elsif data_selectors[:head].map { |e| e[:element][:name] }.include?(datarable.name.downcase) && !datarable.text.blank?
          header = Header.create(text: datarable.text.strip, name: datarable.name)
          content.content_references.create(datarable: header)
        end
      end
    end
  end

  def check_element(selectors,element)
    selectors.each do |key,selector|
      selector.each do |s|
        if element.name.downcase == s[:element][:name]
          return check_parent(s[:parent],element)
        end
      end
    end
    false
  end

  def check_parent(parent_selectors,element)
    parent = element.parent
    while parent.try(:parent) do
      if parent_selectors[:name] == parent.name.downcase
        if parent.attributes['class']
          if parent.attributes['class'].value.split(' ').include?(parent_selectors[:class])
            return true
          end
        end
      end
      parent = parent.parent
    end
    false
  end
end

