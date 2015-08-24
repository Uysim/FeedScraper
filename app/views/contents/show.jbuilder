json.(@content, :title)
json.images @content.images.map { |e| e.link_url }
json.body @content.bodies.map { |e| e.text }.join(" ")