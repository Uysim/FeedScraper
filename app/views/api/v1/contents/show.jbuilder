html_title = "<h1>#{@content.title}</h1>"
content_references=@content.content_references.order(:id)

html_body=content_references.each_with_index.map do |cr,index|
  if cr.datarable.class.name ==  'Body'
    "<p>#{cr.datarable.text}</p>"
  elsif cr.datarable.class.name ==  'Header'
    "<h3>#{cr.datarable.text}</h3>"
  elsif cr.datarable.class.name ==  'Image'
    "<div class='item item-image'><img src='#{cr.datarable.link_url}'></div>"
  end
end.join('')
html_create="<span>#{@content.created_at.strftime("%B %d, %Y")}</span>"
json.data "<div class='item item-body content-item'>#{html_title}#{html_create}#{html_body}</div>"
json.created_at @content.created_at.strftime("%B %d, %Y")