class UsersController < ApplicationController
  before_filter :skip_first_page, :only => :new
  
  def new
  	@user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user.nil?

      @user = User.new(user_params)

      @referred_by = User.find_by_referral_code(cookies[:h_ref])

      if !@referred_by.nil?
        @user.referrer = @referred_by
      end

      @user.save

      # Sends email to user when user is created
      UserMailer.signup_email(@user).deliver_now

    end
	#@user = User.create(user_params)
    #if @user.save
    	#session[:user_id] = @user.id
      #redirect_to '/about'
    #else
      #redirect_to '/users/refer'
    #end
      respond_to do |format|
        if !@user.nil?
          cookies[:h_email] = { :value => @user.email }
          format.html { redirect_to '/users/refer' }
        else
          format.html { redirect_to '/users/new', :alert => "Beam me up, Scotty!" }
        end
      end

  end

  def refer
  	email = cookies[:h_email]
  	@user = User.find_by_email(email)
  end

    private
	
	  def user_params
	    params.require(:user).permit(:email)
      end

      def skip_first_page
        #if !Rails.application.config.ended
           email = cookies[:h_email]
           if email and !User.find_by_email(email).nil?
             redirect_to '/users/refer'
           else
             cookies.delete :h_email
           end
        #end
      end      

end
