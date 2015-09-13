class CategoriesSelector < ActiveRecord::Base
  belongs_to :website

  TYPE = {
    parent: "Parent",
    element: "Element"
  }
end
