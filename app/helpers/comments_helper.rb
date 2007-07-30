module CommentsHelper
  def comment_author(comment)
    c = comment_split(comment)
    c.length > 1 ? c.last : comment.nickname 
  end
    
  def comment_split(comment)
    comment.body.split(' by ')
  end
end
