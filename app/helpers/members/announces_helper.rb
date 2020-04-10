module Members::AnnouncesHelper
  def announce_table(announce)
    article       = link_to Article.model_name.human, announce.article, class: "AnnounceTarget"
    tweet         = link_to Tweet.model_name.human, announce.tweet, class: "AnnounceTarget"
    tweet_comment = link_to TweetComment.model_name.human, announce.tweet_comment.try(:tweet), class: "AnnounceTarget"
    message       = link_to Message.model_name.human, announce.message.try(:room), class: "AnnounceTarget"
    announcer     = link_to announce.announcer.name, announce.announcer, class: "AnnounceTarget"
    announcer_img = link_to (attachment_image_tag announce.announcer, :profile_image, size: 30, format: 'jpeg', fallback: "no_image.jpg", size: 30), announce.announcer, class: "AnnounceImage"

    case announce.action
      when "article_favorite"
        "#{announcer_img}#{announcer}があなたの#{article}をお気に入りに追加しました"
      when "tweet_favorite"
        "#{announcer_img}#{announcer}があなたの#{tweet}にいいね！しました"
      when "tweet_comment_favorite"
        "#{announcer_img}#{announcer}があなたの#{tweet_comment}にいいね！しました"
      when "tweet_comment"
        if announce.tweet.member_id == announce.reciever_id
          "#{announcer_img}#{announcer}があなたの#{tweet}にコメントしました"
        else
          reciever      = link_to announce.tweet.member.name, announce.reciever, class: "AnnounceTarget"
          reciever_img  = link_to (attachment_image_tag announce.tweet.member, :profile_image, size: 30, format: 'jpeg', fallback: "no_image.jpg", size: 30), announce.tweet.member, class: "AnnounceImage"
          "#{announcer_img}#{announcer}が#{reciever_img}#{reciever}の#{tweet}にコメントしました"
        end
      when "message"
        "#{announcer_img}#{announcer}からあなたに#{message}が届きました"
      when "follow"
        "#{announcer_img}#{announcer}があなたをフォローしました"
    end
  end
end