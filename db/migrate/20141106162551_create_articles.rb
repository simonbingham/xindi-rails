class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :slug, :limit => 150
      t.string :title, :limit => 150
      t.text :content
      t.boolean :meta_generated
      t.string :meta_title, :limit => 200
      t.string :meta_description, :limit => 200
      t.string :meta_keywords, :limit => 200
      t.string :author, :limit => 100

      t.timestamps
    end
  end
end
