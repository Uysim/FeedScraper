class RemoveSelector < ActiveRecord::Base
  belongs_to :website
  TYPE = {
    home_page: "Home Page",
    category_page: "Category Page",
    sub_category_page: "Sub Category Page",
    content_page: "Content Page"
  }
end
