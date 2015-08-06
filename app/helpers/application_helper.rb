module ApplicationHelper
  # Return "active" if the current page is the desired page; used to
  # set the nav-bar element.
  def active_class(*link_paths)
    matches = link_paths.select do |path|
      current_page?(path) ? "active" : nil
    end.compact
    matches.empty? ? "" : "active"
  end

  def friendly_boolean(val)
    val ? 'yes' : 'no'
  end

  def lcfirst(str)
    (str[0].downcase + str[1..-1]) if str && str[0]
  end

  def panel_title_div(title)
    if title.present?
      res = <<END
<div class="panel-heading">
  <h3 class="panel-title">#{title}</h3>
</div>
END
      res.html_safe
    else
      ''
    end
  end
end
