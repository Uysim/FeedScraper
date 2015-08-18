class Selector < ActiveRecord::Base
  TYPE = {  type_parent: "Parent",
            type_element: "Element",
            type_data_tag: "Data tag",
            content_link: "Content Link",
            content_title: "Content Title",
            content_image: "Content Image",
            content_body: "Content Body"
          }
  belongs_to :website
end
