class RegistrationController < ApplicationController

  def get_session_params
    if(params[:team_id])
      @team = Team.find(params[:team_id])
      @competitors = @team.competitors
      @team_pool = @team.team_pool
    elsif(params[:team_pool_id])
      @team_pool = TeamPool.find(params[:team_pool_id])
      @team = @team_pool.teams.build
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
    @fields = EventSetting.competitor_fields(@event) 
    if (! @fields[:nation]) or (! @fields[:competing_club]) or (! @fields[:birthdate_y])
      @search_form = false
      @form_url = registration_team_members_url
    else
      @search_form = true
      @form_url = registration_search_user_url
    end
    
    if params[:comp_index].to_i >= 0 and @competitors.count > params[:comp_index].to_i
      @competitor = @competitors[params[:comp_index].to_i]
    else
      @competitor = Competitor.new
    end
    
    set_session_params
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
    @form_url = registration_team_members_url
    
    # Search user if userdata submitted
    if params[:user]
      udata = params[:user]
      cmembers = User.where(:id => ClubMember.where(:club_id => params[:club_id]).map{|cm| cm.user_id})
    
      if udata[:username].empty?
        res_users = cmembers.where(:first_name => udata[:first_name], :last_name => udata[:last_name], :birthdate_y => udata[:birthdate_y], :club_id => udata[:club_id])
      else
        res_users = cmembers.where(:username => udata[:username])
      end      
      
      # One result
      if res_users.count == 1
        @competitor = Competitor.build_from_user(res_users.first,Club.find(params[:club_id]),@team_pool)
        if(@competitors.empty?)
          @competitor.sortkey = 1
        else
          @competitor.sortkey = @competitors.map{|c| c.sortkey}.max + 1
        end
        
        cfields = EventSetting.competitor_fields(@event)
        showform = false
        cfields.each do |key,f|
          if key == :address
            if f[:required?] and ( (@competitor.address_line_1.empty? and @competitor.address_line_2.empty?) or @competitor.city.empty? or @competitor.country_id.nil? or @competitor.zipcode.empty?)
              showform = true
            end
            elsif f[:required?] and @competitor.attributes[key].empty?
            showform = true
          end
        end
        
        if !showform
          @competitors << @competitor #TODO validate
          set_session_params
          redirect_to registration_team_members_url
        end
      else
        if res_users.empty?
          flash[:notice] = t('registration.search_user.runner_not_found')
        else
          flash[:notice] = t('registration.search_user.multiple_runners_found')
        end
        @competitor = Competitor.new
        @competitor.first_name  = params[:user][:first_name]
        @competitor.last_name   = params[:user][:last_name]
        @competitor.birthdate_y = params[:user][:birthdate_y]
        @competitor.nation_id  =  params[:user][:nation_id]
      end
    end
  end

  # GET /registration/team_options
  def team_options
    get_session_params
  end    
  
end
