module LinksHelper
  def visitor_name(visit)
    (visit.user.username if visit.user) || "Anonymous"
  end
end
