class RegistrationController < ApplicationController
  
  # GET /registration/overview
  def overview
    @event = Event.find(params[:event_id])
    @title = @event.name
    @competition_groups = CompetitionGroup.find(Event.find(params[:event_id]).competitions.map(&:competition_group_id))
    if @competition_groups.count == 1
      redirect_to :action => 'main', :competition_group_id => @competition_groups[0].id
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
      redirect_to :action => 'team_members', :competition_group_id => params[:competition_group_id] 
    end
  end

  #GET /registration/team_members
  def team_members
    @competition_group = CompetitionGroup.find(params[:competition_group_id])
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
    
  end
  
  # DELETE /registration/team_members
  def team_removemember
    
  end
  
  # POST /registration/team_save
  def team_save
    #TODO
    redirect_to team_options_url(:team_id => @team.id)
  end
  
  # POST /registration/search_user
  def search_user
    @user = User.where(params[:user])
  end

  def team_options
  end

end