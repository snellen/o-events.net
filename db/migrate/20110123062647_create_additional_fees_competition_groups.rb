class CreateAdditionalFeesCompetitionGroups < ActiveRecord::Migration

  def self.up
    create_table :additional_fees_competition_groups, :id => false do |t|
      t.integer :additional_fee_id
      t.integer :competition_group_id
    end
  end

  def self.down
    drop_table :additional_fees_competition_groups
  end
end
