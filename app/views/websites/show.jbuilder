json.(@website,:name)
json.categories @website.categories do |category|
  json.id category.id
  json.name category.name
end