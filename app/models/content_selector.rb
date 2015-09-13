class ContentSelector < ActiveRecord::Base
  belongs_to :website
  TYPE = {
    parent: 'Parent',
    title: 'Title',
    paragraph: 'Paragraph',
    image: 'Image',
    head: 'Head'
  }
end
