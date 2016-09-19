module WelcomeHelper
  def check_action
    render "welcome/call_to_action" unless current_user
  end
end
