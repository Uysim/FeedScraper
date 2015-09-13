json.(@website,:name)
json.categories @website.categories.where(enable: true) do |category|
  json.id category.id
  json.name category.name
end