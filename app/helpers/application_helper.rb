module ApplicationHelper
  def left_sidebar_link(text, path, icon, options = {})
    link_to path, class: "menu-row flex-row d-flex #{options[:wrapper_options][:class] if options[:wrapper_options]}", method: options[:method] || :get do
      concat fa_icon(icon)
      concat content_tag(:span, text)
    end
  end
    
  def alert_colors_helper(name, msg)    
    notice_class = case name
    when "notice", "info" then "info"
    when "success" then "success"
    when "alert", "warning" then "warning"
    when "error", "danger" then "danger"      
    end

    content_tag :div, class: "alert alert-#{notice_class} alert-dismissible fade show", role: "alert" do
      concat msg
      concat(
        content_tag(:button, type: "button", class: "close close-flash-message", aria: { label: "Close"}, data: { dismiss: "alert"}) do
          content_tag :span, "&times;".html_safe ,aria: { hidden: "true" }
        end
      )
    end
  end

  def segments_route
    if current_user.common?
      segment_path(current_user.segments.first)
    else
      segment_path(root_segment)
    end
  end

  def authorized_for?(resource, action = nil)
    Authorizer.new(current_user).authorize(resource, action)
  end

  def filter_active?(filter_key, values = [])
    params[:q] ? filter_in_params?(filter_key) && values.map(&:to_s).include?(params[:q][filter_key].to_s) : false
  end

  def filter_in_params?(filter_key)
    params[:q].keys.map(&:to_sym).include?(filter_key.to_sym)
  end

  def root_segments_route
    return "#" if !current_user.representative? && !current_user.admin? && !current_user.super_admin?
    segment_path(root_segment)
  end

  def root_segment_users_route
    return "#" if !current_user.representative? && !current_user.admin? && !current_user.super_admin?
    if current_user.admin? || current_user.super_admin?
      users_path
    else
      segment_users_path(root_segment)
    end
  end

  def prep_capture_process_route
    if current_user.segments.present?
      new_segment_prep_process_path(current_user.segments.last)
    elsif current_user.admin? || current_user.super_admin?
      segment_path(root_segment)
    end
  end

  private

  def root_segment
    if current_user.representative?
      current_user.represented_segments.first
    elsif current_user.admin? || current_user.super_admin?
      Segment.find_by(parent_id: nil)
    else
      nil
    end
  end
end
