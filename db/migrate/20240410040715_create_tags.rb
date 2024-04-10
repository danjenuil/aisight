class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_join_table(:images, :tags)
  end
end
