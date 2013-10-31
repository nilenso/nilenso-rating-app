class CreateRatingSets < ActiveRecord::Migration
  def change
    create_table :rating_sets do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
