class UserSessionsController < ApplicationController

  skip_before_filter :login_or_oauth_required, :except => :destroy
  before_filter :require_no_user, :only => :new

  def index
    puts "--------index---------------"
    puts @company
    if @company
      redirect_to :action => "new"
    end
  end

  def new
    puts "---------new--------------"
    @user_session = @company.user_sessions.new
  end

  def create
    # TODO REFACTOR IN FUTURE WITH A BETTER WAY
    admin_company = Company.find_by_subdomain("admin")
    admin_session = admin_company.user_sessions.new(params[:user_session]) if admin_company
    if admin_company && admin_session.valid?
      @user_session = admin_session
    else
      @user_session = @company.user_sessions.new(params[:user_session])
    end
    #@user_session = UserSession.new(params[:user_session]) # To by pass admin
    #@user = find_user(params[:user_session][:login])
    if @user_session.save
      #if @user.activate?
        flash[:notice] = t('user_session.logged_in')
        redirect_back_or_default(home_path)
      #else
      #  flash[:error] = t('user_session.unverified')
      #  destroy_session!
      #end
    else
      flash[:error] = t('user_session.wrong_parameter')
      destroy_session!
    end
  end

  def destroy
    current_user_session.destroy   
    redirect_to root_url
  end
  
  protected

  def find_user(login)
    @company.users.scoped_by_login(login).first
  end

  def check_active_accounts
    unless @company.users.any?{|u| u.activate }
      flash[:error] = t('user_session.no_activate_users')
      redirect_to welcome_accounts_path(:subdomain => @company.subdomain)
    end
  end

end
