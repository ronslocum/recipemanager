class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    #the ||= prevents hitting the db every time the user variable is accessed.
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id] #This if prevents passing nil into the find method
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action."
      redirect_to :back
    end
  end
end
