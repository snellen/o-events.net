class RegistrationController < ApplicationController

  def get_session_params
    if(params[:team_id])
      @team = Team.find(params[:team_id])
      @competitors = @team.competitors
      @team_pool = @team.team_pool
    elsif(params[:team_pool_id])
      @team_pool = TeamPool.find(params[:team_pool_id])
      @team = Team.new
      @competitors = []
    elsif(session[:reg_team])
      @team = session[:reg_team]
      @competitors = session[:reg_competitors]
      @team_pool = @team.team_pool
    end
    
    @event = @team_pool.event
    @title = @event.name
  end
  
  def set_session_params
      session[:reg_team]        = @team
      session[:reg_competitors] = @competitors      
  end
  
  # GET /registration/overview
  def overview
    @event = Event.find(params[:event_id])
    @title = @event.name
    @team_pools = @event.team_pools
    if @team_pools.count == 1
      redirect_to registration_main_url(:team_pool_id => @team_pools.first.id)
    end
  end

  # GET /registration/main
  def main
    @team_pool = TeamPool.find(params[:team_pool_id])
    @teams = @team_pool.teams.where(:user_id => session[:user_id])
    @event = @team_pool.event
    @title = @event.name
    if @teams.empty?
      redirect_to registration_team_members_url(:team_pool_id => @team_pool.id)
    end
  end
  
  #GET /registration/team_members
  def team_members
    get_session_params    
     
  end

  
  # POST /registration/team_members
  def team_addmember
    get_session_params
 
    set_session_params
    redirect_to registration_team_members_url
  end
  
  # DELETE /registration/team_members
  def team_removemember
    get_session_params
    
    set_session_params
    redirect_to registration_team_members_url
  end
  
  # POST /registration/team_save
  def team_save
    get_session_params
    
    set_session_params
    redirect_to registration_team_options_url
  end
  
  # POST /registration/search_user
  def search_user
    get_session_params
    
    udata = params[:user]
    cmembers = User.where(:id => ClubMember.where(:club_id => params[:club_id]).map{|cm| cm.user_id})
    
    if udata[:username].nil?
      res_users = cmembers.where(:first_name => udata[:first_name], :last_name => udata[:last_name], :birthdate_y => udata[:birthdate_y])
    else
      res_users = cmembers.where(:username => udata[:username])
    end      
    
    # One result: Create a competitor, add to team
    if res_users.count == 1 then
      comp = Competitor.build_from_user(res_users.first,Club.find(params[:club_id]),@team_pool)      
      if(@competitors.empty?)
        comp.sortkey = 1
      else
        comp.sortkey = @competitors.maximum(:sortkey) + 1 # TODO this doesn't work on arrays
      end
      @competitors << comp      
      redirect_to registration_team_members_url(:team_id => params[:team_id], :competition_group_id => params[:competition_group_id])
    else
      if res_users.empty? then
        flash[:notice] = t('.runner_not_found')
      else
        flash[:notice] = t('.multiple_runners_found')
      end
      comp = Competitor.new
      comp.first_name  = params[:user][:first_name]
      comp.last_name   = params[:user][:last_name]
      comp.birthdate_y = params[:user][:birthdate_y]
      comp.nation_id  = params[:user][:nation_id]
      @competitors << comp
    end
  end

  # GET /registration/team_options
  def team_options
    get_session_params
  end    
  
end
