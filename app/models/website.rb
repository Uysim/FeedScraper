class Website < ActiveRecord::Base
  has_many :remove_selectors, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :contents, through: :categories
  has_many :categories_selectors, dependent: :destroy
  has_many :list_selectors, dependent: :destroy
  has_many :content_selectors, dependent: :destroy
  accepts_nested_attributes_for :categories_selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :list_selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :content_selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :remove_selectors, reject_if: proc { |attributes| attributes[:selector].blank? }, :allow_destroy => true

  def get_selector(selector,key)
    send(selector).where(selector_type: selector.to_s.classify.constantize::TYPE[key]).map{|e| e.try(:selector)}
  end

  def fetch_type
    page = Nokogiri::HTML(open(link_url))
    get_selector(:categories_selectors,:parent).each do |type_parent_selector|
      type_parents=page.css type_parent_selector
      type_parents.each do |type_parent|
        get_selector(:categories_selectors,:element).each do |element_selector|
          type_elements=type_parent.css element_selector
          type_elements.each do |type_element|
            categories.where(name: type_element.children.text.strip, link_url: type_element.attributes["href"].value).first_or_create
          end
        end
      end
    end
  end

  def all_selectors
    selectors={}
    [ListSelector,CategoriesSelector,ContentSelector,RemoveSelector].each do |klass|
      temp_selectors={}
      klass::TYPE.each do |k,type|
        temp_selectors[k]=get_selector(klass.model_name.route_key.to_sym,k)
      end
      selectors[klass.model_name.route_key.to_sym]=temp_selectors
    end
    selectors[:data_selectors] = parse_content_selector(selectors[:content_selectors])
    selectors
  end

  def fetch_content(lim)
    puts "Fetching Content : #{name}"
    home_page_agent = create_agent link_url
    selectors=all_selectors
    categories.where(enable: true).each do |category|
      category.fetch_content(selectors,home_page_agent,lim)
    end
  end

  def parse_content_selector(selectors)
    # binding.pry
    def map_selector(e_selector)
      e_selector.map do |selector|
        each_selector=selector.split(' ')
        element = each_selector[-1].split('.')
        parent = each_selector[-2].split('.')
        {
          element: {
            name: element.first,
            class: element.last
          },
          parent: {
            name: parent.first,
            class: parent.last
          }
        }
      end
    end
    {
      para: map_selector(selectors[:paragraph]),
      image: map_selector(selectors[:image]),
      head: map_selector(selectors[:head])
    }
  end
end
