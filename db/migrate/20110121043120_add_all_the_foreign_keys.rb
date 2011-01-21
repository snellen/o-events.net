class AddAllTheForeignKeys < ActiveRecord::Migration
  def self.up
    add_column :additional_fees, :event_id, :integer
    add_column :additional_fees, :age_range_id, :integer
    add_column :age_ranges, :event_id, :integer
    add_column :categories, :competition_id, :integer
    add_column :categories, :category_group_id, :integer
    add_column :category_groups, :competition_group_id, :integer
    add_column :chips, :run_id, :integer
    add_column :chips, :competitor_id, :integer
    add_column :clubs, :country_id, :integer
    add_column :club_members, :user_id, :integer
    add_column :club_members, :club_id, :integer
    add_column :competing_clubs, :country_id, :integer
    add_column :competing_clubs, :club_id, :integer
    add_column :competitions, :event_id, :integer
    add_column :competitions, :competition_group_id, :integer
    add_column :competitors, :country_id, :integer
    add_column :competitors, :nation_id, :integer    
    add_column :competitors, :event_id, :integer
    add_column :competitors, :competing_club_id, :integer
    add_column :competitors, :user_id, :integer
    add_column :events, :club_id, :integer
    add_column :events, :country_id, :integer
    add_column :events, :currency_id, :integer    
    add_column :nation_groups, :event_id, :integer
    add_column :payments, :payment_group_id, :integer
    add_column :payments, :currency_id, :integer
    add_column :payment_groups, :user_id, :integer
    add_column :registration_deadlines, :event_id, :integer
    add_column :results, :chip_id, :integer
    add_column :runs, :competition_id, :integer
    add_column :split_times, :result_id, :integer    
    add_column :start_blocks, :competitor_id, :integer
    add_column :start_blocks, :run_id, :integer
    add_column :start_fees, :age_range_id, :integer
    add_column :start_fees, :category_group_id, :integer
    add_column :start_fees, :competition_group_id, :integer
    add_column :start_fees, :registration_deadline_id, :integer        
    add_column :start_fees, :nation_group_id, :integer
    add_column :start_times, :competitor_id, :integer
    add_column :start_times, :run_id, :integer    
    add_column :teams, :payment_group_id, :integer
    add_column :teams, :category_id, :integer
    add_column :team_members, :competitor_id, :integer
    add_column :team_members, :team_id, :integer
    add_column :total_results, :team_id, :integer
    add_column :total_results, :competition_id, :integer        
    add_column :users, :country_id, :integer
    add_column :users, :nation_id, :integer
  end

  def self.down
    remove_column :additional_fees, :event_id
    remove_column :additional_fees, :age_range_id
    remove_column :age_ranges, :event_id
    remove_column :categories, :competition_id
    remove_column :categories, :category_group_id
    remove_column :category_groups, :competition_group_id
    remove_column :chips, :run_id
    remove_column :chips, :competitor_id
    remove_column :clubs, :country_id
    remove_column :club_members, :user_id
    remove_column :club_members, :club_id
    remove_column :competing_clubs, :country_id
    remove_column :competing_clubs, :club_id
    remove_column :competitions, :event_id
    remove_column :competitions, :competition_group_id
    remove_column :competitors, :country_id
    remove_column :competitors, :nation_id
    remove_column :competitors, :event_id    
    remove_column :competitors, :competing_club_id
    remove_column :competitors, :user_id
    remove_column :events, :club_id
    remove_column :events, :country_id
    remove_column :events, :currency_id
    remove_column :nation_groups, :event_id
    remove_column :payments, :payment_group_id
    remove_column :payments, :currency_id
    remove_column :payment_groups, :user_id
    remove_column :registration_deadlines, :event_id
    remove_column :results, :chip_id
    remove_column :runs, :competition_id
    remove_column :split_times, :result_id
    remove_column :start_blocks, :competitor_id
    remove_column :start_blocks, :run_id
    remove_column :start_fees, :age_range_id
    remove_column :start_fees, :category_group_id
    remove_column :start_fees, :competition_group_id
    remove_column :start_fees, :registration_deadline_id
    remove_column :start_fees, :nation_group_id
    remove_column :start_times, :competitor_id
    remove_column :start_times, :run_id
    remove_column :teams, :payment_group_id
    remove_column :teams, :category_id
    remove_column :team_members, :competitor_id
    remove_column :team_members, :team_id
    remove_column :total_results, :team_id
    remove_column :total_results, :competition_id
    remove_column :users, :country_id
    remove_column :users, :nation_id
  end
end
