class ContentReference < ActiveRecord::Base
  belongs_to :content
  belongs_to :datarable, polymorphic: true
end
