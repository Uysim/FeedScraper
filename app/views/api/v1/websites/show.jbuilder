json.(@website,:name)
json.sliders @website.contents.last(5) do |content|
  json.id content.id
  json.name content.title
  json.thumnail content.thumnail
  json.created_at content.created_at.strftime("%B %d, %Y")
end
json.categories @website.categories.where(enable: true) do |category|
  json.id category.id
  json.name category.name
end
