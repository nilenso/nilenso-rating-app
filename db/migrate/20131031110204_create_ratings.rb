class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :rating_set, index: true
      t.references :rated_user, index: true

      t.timestamps
    end
  end
end
