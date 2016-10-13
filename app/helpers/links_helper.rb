module LinksHelper
  def visitor_name(visit)
    if visit.user
      visit.user.username
    else
      "Anonymous"
    end
  end
end
