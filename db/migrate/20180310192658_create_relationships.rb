class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :followed
      t.integer :following

      t.timestamps
    end
    add_index :relationships, :following
    add_index :relationships, :followed
    add_index :relationships, [:following, :followed], unique: true
  end
end
