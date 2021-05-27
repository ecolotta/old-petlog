class CreateDogCares < ActiveRecord::Migration[6.1]
  def change
    create_table :dog_cares do |t|
      t.integer :dog_id
      t.integer :care_type_id

      t.timestamps
    end
  end
end
