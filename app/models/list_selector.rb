class ListSelector < ActiveRecord::Base
  belongs_to :website
  TYPE = {
    parent: 'Parent',
    link_element: 'Link',
    thumnail: 'Thumnail',
    snippet: 'Snippet'
  }
end
