json.array!(@websites) do |website|
  json.id website.id
  json.name website.name
end