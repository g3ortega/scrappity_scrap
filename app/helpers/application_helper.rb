module ApplicationHelper
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end

  def submit_text
    mobile_device? ? "Search" : "Search RailsConf Abstracts!"
  end

end
