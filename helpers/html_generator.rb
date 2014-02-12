module HTMLGenerator
  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def to_link(href, title, class_name = nil)
    class_tag = class_name.nil? ? "" : "class='#{class_name}'"
    "<a #{class_tag} href='#{href}'>#{title}</a>"
  end

  def pagination_link(fullpath, page)
    pattern = /([\?|&]page=)(\d*)/
    if(pattern.match(fullpath))
      fullpath.gsub(pattern, '\1' + page.to_s)
    else
      symbol = fullpath.include?('?') ? "&" : "?"
      "#{fullpath}#{symbol}page=#{page}"
    end
  end
end