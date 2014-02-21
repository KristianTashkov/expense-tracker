module HTMLGenerator
  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def to_link(href, title, class_name = nil)
    class_tag = class_name.nil? ? "" : "class='#{class_name}'"
    "<a #{class_tag} href='#{href}'>#{title}</a>"
  end

  def add_parameter_to_link(link, parameter, value)
    pattern = /([\?|&]#{parameter}=)(\d*)/
    if(pattern.match(link))
      link.gsub(pattern, '\1' + value.to_s)
    else
      symbol = link.include?('?') ? "&" : "?"
      "#{link}#{symbol}#{parameter}=#{value}"
    end
  end
end