module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def likes_count(post)
    "Likes: #{post.likes.count}"
  end

  def comments_count(post)
    "Comments: #{post.comments.count}"
  end

  def friendship_button(user)
    return if user == current_user

    if current_user.friend? user
      link_to 'Unfriend', friendship_path(user.id), class: 'btn btn-unfriend', method: :delete, remote: true
    elsif current_user.friend_requests_sent.pluck(:user_id, :friend_id).any?([current_user.id, user.id])
      link_to 'Cancel Request', friendship_path(user.id), class: 'btn btn-cancel', method: :delete, remote: true
    elsif current_user.friend_requests_received.pluck(:user_id, :friend_id).any?([user.id, current_user.id])
      link_to('Accept', friendship_path(user.id), class: 'btn btn-accept', method: :patch, remote: true) +
        link_to('Reject', friendship_path(user.id), class: 'btn btn-reject', method: :delete, remote: true)
    else
      link_to 'Add Friend', friendships_path(id: user.id), class: 'btn btn-add', method: :post, remote: true
    end
  end

  def friend_request_header(user)
    content_tag :h3, 'Friend Requests:' if user == current_user
  end

  def list_friend_requests(user)
    if current_user != user
      friendship_button(user)
    else
      render user.friend_requests
    end
  end

  def mutual_friends_header(user)
    content_tag :h4, 'Mutual Friends:', class: 'mutual-header' if user != current_user
  end

  def list_mutual_friends(user)
    render(user.mutual_friends(user).reject { |friend| friend == current_user }) if user != current_user
  end

  def show_menu_links
    if current_user
      link_to(current_user.name, user_path(current_user), class: 'menu-item') +
        link_to('Sign out', destroy_user_session_path, method: :delete)
    else
      link_to 'Sign in', user_session_path
    end
  end
end
