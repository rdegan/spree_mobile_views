module Spree
  module MobileHelpers
    def self.included(receiver)
      receiver.send :helper_method, :spree_mobile_device?
      receiver.send :before_filter, :spree_prepare_for_mobile
      receiver.send :before_filter, :spree_prepend_view_path_if_mobile
    end
    
    def spree_mobile_device?
      if cookies[:mobile_param]
        cookies[:mobile_param] == "1"
      else
        request.user_agent.to_s.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
      end
    end

    def spree_prepare_for_mobile
      cookies[:mobile_param] = params[:mobile] if params[:mobile]
    end

    def spree_prepend_view_path_if_mobile
      if spree_mobile_device?
        prepend_view_path File.join(File.dirname(__FILE__), '..', 'app', 'mobile_views')
        prepend_view_path File.join(Rails.root, 'app', 'mobile_views')
      end
    end
  end
end
