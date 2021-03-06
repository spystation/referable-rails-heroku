class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ref_to_cookie

  def ref_to_cookie
    if params[:ref] #&& !Rails.application.config.ended
      if !User.find_by_referral_code(params[:ref]).nil?
        cookies[:h_ref] = { :value => params[:ref]} #, :expires => 1.week.from_now }
      end

       #if request.env["HTTP_USER_AGENT"] and !request.env["HTTP_USER_AGENT"].include?("facebookexternalhit/1.1")
          #redirect_to proc { url_for(params.except(:ref)) }  
       #end
    end
  end  
end
