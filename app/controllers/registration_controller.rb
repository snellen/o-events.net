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
    
    if(params[:leader_index])
      @leader_index = params[:leader_index]
    elsif session[:leader_index]
      @leader_index = session[:leader_index]
    else
      @leader_index = 0
    end
    
    @event = @team_pool.event
    @title = @event.name
    
    @fields = EventSetting.competitor_fields(@event)
    @custom_fields = EventSetting.custom_fields('competitor',@event)    
  end
  
  def set_session_params
      session[:reg_team]        = @team
      session[:reg_competitors] = @competitors     
      session[:leader_index]    = @leader_index
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
  
  #DELETE /registration/main
  def team_delete
    @team = User.find(session[:user_id]).teams.find(params[:team_id])
    @team_pool = @team.team_pool

    if ! @team.bill and @team.total_results.empty?    
      @team.team_registrations.each do |tr|
        tr.destroy
      end
      
      @team.competitors.each do |c|
        c.destroy
      end
      
      @team.destroy
      redirect_to registration_main_url(:team_pool_id => @team_pool.id, :notice => t('.deleted'))
    else
      redirect_to registration_main_url(:team_pool_id => @team_pool.id, :notice => t('.not_deletable'))
    end
    

  end
  
  #GET /registration/team_members
  def team_members
    get_session_params
    if (! @fields[:nation]) or (! @fields[:competing_club]) or (! @fields[:birthdate_y])
      @search_form = false
      @form_url = registration_team_members_url
    else
      @search_form = true
      @form_url = registration_search_user_url
    end
    
    if params[:competitor_index]
      @competitor = @competitors[params[:competitor_index].to_i]
    else
      @competitor = @event.competitors.build
    end
    
    set_session_params
  end

  
  # POST /registration/team_members
  def team_addmember
    get_session_params
 
    @competitor = @event.competitors.build
    @competitor.attributes = params[:competitor] #TODO: is this safe?
    @competitor.sortkey = 1
    
    if @competitor.valid?
       if params[:competitor_index]
         @competitors[params[:competitor_index].to_i] = @competitor
       else
         @competitors << @competitor
       end
       set_session_params       
       redirect_to registration_team_members_url
    else
       render :action => 'team_members'
    end
      
  end
  
  # DELETE /registration/team_members
  def team_removemember
    get_session_params
  
    if params[:competitor_index]
      @competitors.delete_at(params[:competitor_index].to_i)
    end
    
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
    @fields = EventSetting.competitor_fields(@event)
    @custom_fields = EventSetting.custom_fields('competitor',@event)
    
    # Search user if userdata submitted
    if params[:user]
      udata = params[:user]
    
      if udata[:username].empty?
        uclub = Club.find(udata[:competing_club_id])
        cmembers = User.where(:id => uclub.club_members.map{|cm| cm.user_id})
        res_users = cmembers.where(:first_name => udata[:first_name], :last_name => udata[:last_name], :birthdate_y => udata[:birthdate_y], :club_id => udata[:club_id])
      else
        res_users = User.where(:username => udata[:username])
        if res_users.count == 1
          uclub = ClubMember.where(:user_id => res_users.first.id, :is_default => true).first
          # TODO: Always show the form let the user select from their clubs; add a "New Club" button that opens a popup window.
        end
      end      
      
      # One result
      if res_users.count == 1
        @competitor = Competitor.build_from_user(res_users.first,uclub,@team_pool)
        @competitor.event = @event
        @competitor.sortkey = 1 # actual sortkey will be set when saving team
        
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
          if @competitor.valid?
            @competitors << @competitor
            set_session_params
            redirect_to registration_team_members_url
          end
        end
        
      else # More than one result
        
        if res_users.empty?
          flash[:notice] = t('registration.search_user.runner_not_found')
        else
          flash[:notice] = t('registration.search_user.multiple_runners_found')
        end
        @competitor = @event.competitors.build
        @competitor.first_name  = params[:user][:first_name]
        @competitor.last_name   = params[:user][:last_name]
        @competitor.birthdate_y = params[:user][:birthdate_y]
        @competitor.nation_id  =  params[:user][:nation_id]
      end #if
    else #no user data
      redirect_to registration_team_members_url
    end #if
  end #search_user

  
  # GET /registration/team_options
  def team_options
    get_session_params
  end #team_options    
  
end
