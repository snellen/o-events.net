class RegistrationController < ApplicationController
  
  # GET /registration/overview
  def overview
    @event = Event.find(params[:event_id])
    @title = @event.name
    @competition_groups = CompetitionGroup.find(Event.find(params[:event_id]).competitions.map(&:competition_group_id))
    if @competition_groups.count == 1
      redirect_to registration_main_url(:competition_group_id => @competition_groups.first.id)
    end
  end

  # GET /registration/main
  def main
    @competition_group = CompetitionGroup.find(params[:competition_group_id])
    @teams = @competition_group.teams
    # The following will raise an exception if a CompetitionGroup has no Competitions - but that shouldn't happen at this stage.
    @event = @competition_group.competitions.first.event
    @title = @event.name
    if @teams.empty?
      redirect_to registration_team_options_url(:competition_group_id => @competition_group.id)
    end
  end

  # GET /registration/team_options
  def team_options
    if(params[:team_id])
      @team = Team.find(params[:team_id])
      @competition_group = @team.competition_group
    else
      @team=Team.new
      @competition_group = CompetitionGroup.find(params[:competition_group_id])
    end    
  end  
  
  #GET /registration/team_members
  def team_members
    if(params[:team_id])
      @team = Team.find(params[:team_id])
      @competition_group = @team.competition_group
    else
      @competition_group = CompetitionGroup.find(params[:competition_group_id])
    end
    @event = @competition_group.competitions.first.event
    @title = @event.name

    if params[:team_member_id]
      @team_member = TeamMember.find(params[:team_member_id])
      @team = @team_member.team
    elsif params[:team_id]
      @team = Team.find(params[:team_id])
      @team_member = TeamMember.new
    else
      @team = Team.new
      @team_member = TeamMember.new
    end
  end
  
  # POST /registration/team_members
  def team_addmember
    @team = Team.find(params[:team_id])
    redirect_to registration_team_members_url(:team_id => @team.id)
  end
  
  # DELETE /registration/team_members
  def team_removemember
    @team = Team.find(params[:team_id])
    redirect_to registration_team_members_url(:team_id => @team.id)
  end
  
  # POST /registration/team_save
  def team_save
    #TODO
    redirect_to registration_team_options_url(:team_id => @team.id, :competition_group_id => params[:competition_group_id])
  end
  
  # POST /registration/search_user
  def search_user
    udata = params[:user]
    if udata[:username].nil?
      users = User.where(:first_name => udata[:first_name], :last_name => udata[:last_name], :birthdate_y => udata[:birthdate_y], :nation_id => udata[:nation_id])
    else
      users = User.where(:username => udata[:username])
    end      
    @competition_group = CompetitionGroup.find(params[:competition_group_id])
    @event = @competition_group.competitions.first.event
    if(params[:team_id].nil?)
      @team = Team.new
    else
      @team = Team.find(params[:team_id])
    end
    
    # One result: Create a competitor, add to team
    if users.count == 1 then
      @competitor = Competitor.new(users.first)
      @competitor.save
      @team_member = TeamMember.new      
      @team_member.competitor_id = @competitor.id
      @team_member.team_id = params[:team_id]
      if(params[:team_id].nil?)
        @team_member.sortkey = 1
      else
        @team_member.sortkey = Team.find(params[:team_id]).team_members.maximum(:sortkey) + 1
      end
      @team_member.save
      redirect_to registration_team_members_url(:team_id => params[:team_id], :competition_group_id => params[:competition_group_id])
    else
      if users.empty? then
        flash[:notice] = t('.runner_not_found')
      else
        flash[:notice] = t('.multiple_runners_found')
      end
      @competitor = Competitor.new
      @competitor.first_name  = params[:user][:first_name]
      @competitor.last_name   = params[:user][:last_name]
      @competitor.birthdate_y = params[:user][:birthdate_y]
      @competitor.country_id  = params[:user][:country_id]
    end
  end

end
