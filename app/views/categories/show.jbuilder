json.(@category,:name)
json.website do
  json.id @category.website.id
  json.name @category.website.name
end
items=request.query_parameters[:items].to_i
page=request.query_parameters[:page].to_i
json.contents @category.contents.limit(items).offset(page*items) do |content|
  json.id content.id
  json.name content.title
  json.text content.bodies.map{ |e| e.text }.join(' ').truncate(200)
end