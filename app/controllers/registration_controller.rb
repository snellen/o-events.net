class RegistrationController < ApplicationController
  def overview
    @event = Event.find(params[:event_id])
    @title = @event.name
    @competition_groups = CompetitionGroup.find(Event.find(params[:event_id]).competitions.map(&:competition_group_id))
    if @competition_groups.count == 1
      redirect_to :action => 'main', :competition_group_id => @competition_groups[0].id
    end
  end

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

  def team_members
    @competition_group = CompetitionGroup.find(params[:competition_group_id])
    @event = @competition_group.competitions.first.event
    @title = @event.name

    if params[:team_member_id]
      @team_member = TeamMember.find(params[:team_member_id])
      @team_members = @team_member.team.team_members
    elsif params[:team_id]
      @team_members = Team.find(params[:team_id]).team_members
      @team_member = TeamMember.new
    else
      @team_members = []
      @team_member = TeamMember.new
    end
  end

  def team_options
  end

end
