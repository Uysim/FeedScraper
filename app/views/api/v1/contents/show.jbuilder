html_title = "<div class='item item-text-wrap item-divider'>#{@content.title}<strong></strong></div>"
content_references=@content.content_references.order(:id)
html_body=content_references.each_with_index.map do |cr,index|
  if [Body,Header].include?(cr.datarable.class)
    return_string = ''
    if index==0 || ![Body,Header].include?(content_references[index-1].datarable.class)
      return_string = "#{return_string} <div class='item item-text-wrap'>"
    end
    if cr.datarable.class == Body
      return_string = "#{return_string}<p>#{cr.datarable.text}<p>"
    elsif cr.datarable.class == Header
      return_string = "#{return_string}<h3>#{cr.datarable.text}</h3>"
    end

    if cr == content_references.last || ![Body,Header].include?(content_references[index+1].datarable.class)
      return_string = "#{return_string}</div>"
    end
    return_string
  elsif cr.datarable.class.name ==  'Header'
    "<h3>datarable.text</h3>"
  elsif cr.datarable.class.name ==  'Image'
    "<div class='item item-image'><img src='#{cr.datarable.link_url}'></div>"
  end
end.join('')

json.data "#{html_title}#{html_body}"
json.created_at @content.created_at.strftime("%B %d, %Y")