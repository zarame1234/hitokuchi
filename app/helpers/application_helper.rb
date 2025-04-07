module ApplicationHelper
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
        <div>
          <li class="error_msg">#{msg}</li>
         </div>
      EOF
    end
    html.html_safe
  end
end
