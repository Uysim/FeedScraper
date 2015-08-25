class Website < ActiveRecord::Base
  has_many :selectors
  has_many :categories
  has_many :contents

  accepts_nested_attributes_for :selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true

  def get_selector(key)
    selectors.where(selector_type: Selector::TYPE[key]).first.try(:selector)
  end

  def fetch_type
    page = Nokogiri::HTML(open(link_url))
    type_parents=page.css get_selector(:type_parent)
    type_parents.each do |type_parent|
      type_elements=type_parent.css get_selector(:type_element)
      type_elements.each do |type_element|
        categories.where(name: type_element.children.text, link_url: type_element.attributes["href"].value).first_or_create
        # binding.pry
      end
    end
  end

  def fetch_content
    home_page_agent = create_agent link_url
    categories.each do |category|
      category.fetch_content(home_page_agent)
    end
  end

  def self.count_scraping
    where(scraping: true).count
  end
end
