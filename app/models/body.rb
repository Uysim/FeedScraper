class Body < ActiveRecord::Base
  has_one :content_reference, as: :datarable, dependent: :destroy
end
