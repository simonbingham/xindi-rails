class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address, :limit => 100
      t.string :password_digest

      t.timestamps
    end
  end
end
