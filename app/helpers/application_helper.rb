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
end
