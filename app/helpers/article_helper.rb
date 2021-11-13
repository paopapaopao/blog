module ArticleHelper
  def format_date_time(article)
    article.created_at.strftime("%A, %d %B %Y at %H:%M")
  end

  def created_time_ago(article)
    distance_of_time_in_words(article.created_at, DateTime.now)
  end

  def truncate_body(article)
    # article.body.truncate(400)
    truncate(strip_tags(article.body.to_s), length: 320)
  end
end
