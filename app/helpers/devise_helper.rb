module DeviseHelper

  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    I18n.t("errors.messages.not_saved",
          :count => resource.errors.count,
          :resource => resource.class.model_name.human.downcase)

    #TODO: Did you write this? -jc
    html = <<-HTML
    <div id="error_explanation">
      <div class="alert alert-danger fade in">
        <button class="close" data-dismiss="alert">×</button>
        #{messages}
      </div>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
