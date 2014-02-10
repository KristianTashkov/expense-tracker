module HTMLGenerator
  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def to_link(href, title, class_name = nil)
    class_tag = class_name.nil? ? "" : "class='#{class_name}'"
    "<a #{class_tag} href='#{href}'>#{title}</a>"
  end
end