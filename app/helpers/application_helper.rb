module ApplicationHelper
  def rating_as_stars(rating_average)
    rating_average = rating_average.to_i
    return "⭐️" * rating_average
  end
end
