module ApplicationHelper
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""

    messages_order = ['name', 'email', 'password']
    
    messages_order.each do |field|
      error_messages = resource.errors.full_messages_for(field)
      error_messages.each do |msg|
        html += <<-EOF
          <div>
            <li style="color: #930403;">#{msg}</li>
           </div>
        EOF
      end
    end
    html.html_safe
  end
end
