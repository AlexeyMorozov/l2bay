module ApplicationHelper
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  def show_unless_zero(count)
    yield count if count > 0
  end
end
