module ApplicationHelper
  def select_nav
    if current_user
      render "layouts/admin_nav"
    else
      render "layouts/nav"
    end
  end
end
