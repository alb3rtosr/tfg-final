module UsersHelper
    # Returns the Gravatar for the given user.
    def user_avatar user
        "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?default=identicon&size=100"
    end

    def user_image_tag (user, y, x, cl: "")
      if user.avatar.attached?
        image_tag user.avatar.variant(resize: "#{x}x#{y}!"), class: cl 
      else
        image_tag user_avatar(user), height: x, width: y, class: cl
      end   
    end

    
end