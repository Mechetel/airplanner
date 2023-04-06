
module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(tag.div(message, class: "alert #{bootstrap_class_for(msg_type)}", role: 'alert') do
               concat tag.button('', class: 'btn-close', data: { dismiss: 'alert' })
               concat message
             end)
    end
    nil
  end
end
