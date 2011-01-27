class RegistrationController < ApplicationController
  def overview
    @event = Event.find(params[:event_id])
    @competition_groups = CompetitionGroup.find(Event.find(params[:event_id]).competitions.map(&:competition_group_id))
    if @competition_groups.count == 1
      redirect_to :action => 'main', :competition_group_id => @competition_groups[0].id
    end
  end

  def main
    @teams = CompetitionGroup.find(params[:competition_group_id]).teams
  end

  def team_members
  end

  def team_options
  end

end
