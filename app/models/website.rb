class Website < ActiveRecord::Base
  has_many :selectors
  has_many :remove_selectors
  has_many :categories
  has_many :contents

  accepts_nested_attributes_for :selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :remove_selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true

  def get_selector(key)
    selectors.where(selector_type: Selector::TYPE[key]).map{|e| e.try(:selector)}
  end

  def fetch_type
    page = Nokogiri::HTML(open(link_url))
    get_selector(:type_parent).each do |type_parent_selector|
      type_parents=page.css type_parent_selector
      type_parents.each do |type_parent|
        get_selector(:type_element).each do |element_selector|
          type_elements=type_parent.css element_selector
          type_elements.each do |type_element|
            categories.where(name: type_element.children.text, link_url: type_element.attributes["href"].value).first_or_create
          end
        end
      end
    end
  end

  def fetch_content
    puts "Fetching Content : #{self.name}"
    home_page_agent = create_agent link_url
    categories.each do |category|
      category.fetch_content(home_page_agent)
    end
  end
end
