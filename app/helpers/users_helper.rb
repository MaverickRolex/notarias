module UsersHelper
  def users_index_filter_path(filter, clear = nil)
    window_filters = clear ? params[:q].except(clear) : params[:q] if params[:q]
    # This is the helper for the route
    if @segment
      segment_users_path(@segment, q: filter.merge(window_filters || {}))
    else
      users_path(q: filter.merge(window_filters || {}))
    end
  end

  def users_search_url(from_segment = nil, to_segment = nil)
    if from_segment && to_segment
      select_transfer_users_path(from_id: from_segment, to_id: to_segment)
    elsif @segment
      segment_users_path(@segment, q: params[:q] || {})
    else
      users_path(q: params[:q] || {})
    end
  end

  def users_form_resources
    if @segment
      [@segment, @user]
    else
      @user
    end
  end

  def delete_user_link_url
    if @segment
      segment_user_path(@segment, @user)
    else
      user_path(@user)
    end    
  end

  def lock_user_link_url
    if @segment
      lock_segment_user_path(@segment, @user)
    else
      lock_user_path(@user)
    end    
  end

  def unlock_user_link_url
    if @segment
      unlock_segment_user_path(@segment, @user)
    else
      unlock_user_path(@user)
    end
  end

  def return_link_url
    if @segment
      segment_users_path(@segment, @user)
    else
      users_path(@user)
    end
  end

  def new_user_link_url
    if @segment
      new_segment_user_path(@segment)
    else
      new_user_path
    end
  end
end
