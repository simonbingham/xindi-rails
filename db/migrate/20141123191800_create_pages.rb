class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug, :limit => 150
      t.integer :left_value
      t.integer :right_value
      t.integer :ancestor_id
      t.integer :depth
      t.string :title, :limit => 150
      t.text :content
      t.boolean :meta_generated
      t.string :meta_title, :limit => 200
      t.string :meta_description, :limit => 200
      t.string :meta_keywords, :limit => 200

      t.timestamps
    end
  end
end
