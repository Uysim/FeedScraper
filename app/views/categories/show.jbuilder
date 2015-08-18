json.(@category,:name)
json.website do
  json.id @category.website.id
  json.name @category.website.name
end
json.contents @category.contents do |content|
  json.id content.id
  json.name content.title
  json.text content.bodies[2].text.truncate(200)
end