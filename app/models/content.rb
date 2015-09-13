class Content < ActiveRecord::Base
  belongs_to :website
  belongs_to :contentable, polymorphic: true
  has_many :content_references

  def create_content_images(imgs)
    imgs.each do |img|
      if img.attributes["src"]
        images.where(link_url: img.attributes["src"]).first_or_create
      end
    end
  end

  def create_content_bodies(body_elements)
    body_elements.each do |body|
      bodies.where(text: body.text).first_or_create
    end
  end

end
