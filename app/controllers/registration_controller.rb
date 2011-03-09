class RegistrationController < ApplicationController

  def get_session_params
    if(params[:team_id])
      @team = Team.find(params[:team_id])
      #@competitors = Competitor.where(:team_id => @team.id).map{|c| c} # NOT: @team.competitors
      @competitors = Competitor.where(:team_id => @team.id).find(:all, :order => 'sortkey').map{|c| c.clone}
      @leader_index = Competitor.where(:team_id => @team.id).find(:all, :order => 'sortkey').map{|c| c.id}.index(@team.leader.id)      
      @team_pool = @team.team_pool
    elsif(params[:team_pool_id])
      @team_pool = TeamPool.find(params[:team_pool_id])
      @team = @team_pool.teams.build
      @competitors = []
      @leader_index = 0
    elsif(session[:reg_team])
      @team = session[:reg_team]
      @competitors = session[:reg_competitors]
      @team_pool = @team.team_pool
      @leader_index = session[:leader_index].to_i      
    end 

    if params[:main_category]
      @main_category = params[:main_category]
    elsif @team.id
      @main_category = @team.team_registrations.first.category.id # TODO generalize
    else
      @main_category = 0
    end
      
    @event = @team_pool.event
    @title = @event.name    
  end
  
  def set_session_params
      session[:reg_team]          = @team
      session[:reg_competitors  ] = @competitors   
      session[:reg_main_category] = @main_category
      session[:leader_index]      = @leader_index
  end
  
  def clear_session_params
      session[:reg_team]          = nil
      session[:reg_competitors]   = nil     
      session[:leader_index]      = nil    
      session[:reg_main_category] = nil
  end
  
  # GET /registration/overview
  def overview
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @title = @event.name
      @team_pools = @event.team_pools
      if @team_pools.count == 1
        redirect_to registration_main_url(:team_pool_id => @team_pools.first.id)
      end
    else
      redirect_to events_url
    end
  end

  # GET /registration/main
  def main
    if params[:team_pool_id]
      @team_pool = TeamPool.find(params[:team_pool_id])
      @teams = @team_pool.teams.where(:user_id => session[:user_id])
      @event = @team_pool.event
      @title = @event.name
      deadline = @event.registration_deadlines.order('date DESC').limit(1).first
      @lastRegistrationDeadline =  deadline ? deadline.date : @event.start_date
      puts '@lastRegistrationDeadline => '+@lastRegistrationDeadline.to_s
      @registrationClosed = (@lastRegistrationDeadline < Date.today)
      if @teams.empty?
        redirect_to registration_team_members_url(:team_pool_id => @team_pool.id)
      end
    else
      redirect_to events_url
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
      redirect_to registration_main_url(:team_pool_id => @team_pool.id, :notice => noticeInfo(t('.deleted')))
    else
      redirect_to registration_main_url(:team_pool_id => @team_pool.id, :notice => noticeInfo(t('.not_deletable')))
    end
    

  end
  
  #GET /registration/team_members
  def team_members
    get_session_params
    @fields = EventSetting.competitor_fields(@event)
    @custom_fields = EventSetting.custom_fields('competitor',@event)    
    
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
  # TODO rename action, this is used for "update" and "move" too...
  def team_addmember
    get_session_params
 
    # Move up/down in table
    if params[:move]
      src = params[:competitor_index].to_i
      dest = src + (params[:move] == 'up' ? -1 : 1)
      if dest >= 0 and dest < @competitors.length
        temp = @competitors[dest]
        @competitors[dest] = @competitors[src]
        @competitors[src] = temp
      end
      if @leader_index == src
        @leader_index = dest
      elsif @leader_index == dest
        @leader_index = src
      end
      
      set_session_params      
      redirect_to registration_team_members_url
    
    # Set team leader
    elsif(params[:leader_index])
      @leader_index = params[:leader_index].to_i
      set_session_params      
      redirect_to registration_team_members_url      
      
    # Add/update a team member
    elsif params[:competitor]
      @competitor = @event.competitors.build
      @competitor = Competitor.new
      @competitor.event = @event
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
         @fields = EventSetting.competitor_fields(@event)
         @custom_fields = EventSetting.custom_fields('competitor',@event)
         if (! @fields[:nation]) or (! @fields[:competing_club]) or (! @fields[:birthdate_y])
           @search_form = false
           @form_url = registration_team_members_url
         else
           @search_form = true
           @form_url = registration_search_user_url
         end
         render :action => 'team_members'
      end
    end
      
  end
  
  # DELETE /registration/team_members
  def team_removemember
    get_session_params
  
    if params[:competitor_index]
      #Delete team member
      @competitors.delete_at(params[:competitor_index].to_i)
      
      #Change team leader if necessary
      if @leader_index == params[:competitor_index].to_i && @leader_index > 0
        @leader_index -= 1
      end
    end
    
    set_session_params
    redirect_to registration_team_members_url
  end
  
  # POST /registration/main
  def team_save
    get_session_params
    
    @team.attributes = params[:team] #TODO: is this safe?
    @team.registration_time ||= Time.now #TODO: Make sure to handle this field correctly in existing teams.
    @team.paid_by_club ||= false
    @team.user = User.find(session[:user_id])
    @team.start_fee = 10
    @team.leader = nil
    
    if params[:main_category].to_i > 0
      team_reg = Category.find(params[:main_category].to_i).team_registrations.build
      team_reg.team = @team
      team_reg.competition = @event.competitions.first #TODO: Replace this by generalized code with several team_registrations
      if team_reg.valid?        
        
        #TODO: Later, make sure that the total start fee of paid teams cannot be modified - or at least not reduced.
        @team.team_registrations.each do |reg|
          reg.destroy
        end        
      
        if @team.save  
          
          team_reg.save!
          
          @team.competitors.each do |comp|
            comp.destroy
          end
          
          @competitors.each_with_index do |comp,idx|
            @competitors[idx].sortkey = idx
            @competitors[idx].team = @team
            @competitors[idx].save!            
          end
          
          @team.leader = @competitors[@leader_index]
          @team.save!          
        end #if team
        
        @all_errors = @team.errors
      else
        @all_errors = team_reg.errors        
      end #if team_reg
    else
      @team.errors.clear
      @team.errors.add(:category, I18n.t('activerecord.errors.messages.mustbeselected'))
      @all_errors = @team.errors
    end #if category

    
    if @all_errors.any?
      @fields = EventSetting.team_fields(@event)
      @custom_fields = EventSetting.custom_fields('team',@event)
      render :action => 'team_options'
    else
      clear_session_params
      redirect_to registration_main_url(:team_pool_id => @team_pool.id)
    end
  end #team_save
  
  # POST /registration/search_user
  def search_user
    get_session_params
    @fields = EventSetting.competitor_fields(@event)
    @custom_fields = EventSetting.custom_fields('competitor',@event)
    
    # Search user if userdata submitted
    if params[:user]
      udata = params[:user]
    
      if udata[:username].empty?
        uclub = Club.where(:id => udata[:competing_club_id])
        if uclub.empty?
          res_users = []
        else
          uclub = uclub.first
          cmembers = User.where(:id => uclub.club_members.map{|cm| cm.user_id})
          res_users = cmembers.where(:first_name => udata[:first_name], :last_name => udata[:last_name], :birthdate_y => udata[:birthdate_y])          
        end
      else
        res_users = User.where(:username => udata[:username])
        if res_users.count == 1
          uclub = ClubMember.where(:user_id => res_users.first.id, :is_default => true).first
          # TODO: Always show the form and let the user select from their clubs; add a "New Club" button that opens a popup window.
        end
      end      
      
      # One result
      if res_users.count == 1
        @competitor = Competitor.build_from_user(res_users.first,uclub,@team_pool)
        @competitor.event = @event
        @competitor.sortkey = 1 # actual sortkey will be set when saving team
        
        showform = false
        @fields.each do |key,f|
          if key == :address
            if f[:required?] and ( (@competitor.address_line_1.empty? and @competitor.address_line_2.empty?) or @competitor.city.empty? or @competitor.country_id.nil? or @competitor.zipcode.empty?)
              showform = true
              break
            end
          elsif f[:required?] and @competitor.attributes[key].empty?
            showform = true
            break
          end
        end
        
        @custom_fields.each do |key,f|
          if f[:required?]
            showform = true
            break
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
    @fields = EventSetting.team_fields(@event)
    @custom_fields = EventSetting.custom_fields('team',@event)
    @all_errors = @team.errors

    # TODO: Set competing club and nation to team leader's values if not set for the team (and if fields active at all)
    
    
  end #team_options    
  
end
