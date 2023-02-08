class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.text :desc
      t.string :email
      t.string :password_digest
      t.string :priflie_image
      t.timestamps
    end
  end
end
