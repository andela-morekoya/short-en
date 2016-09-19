module ApplicationHelper
  def select_nav
    if signed_in?
     render "layouts/admin_nav" 
    else 
       render "layouts/nav" 
    end 
  end
end
