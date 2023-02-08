class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :article
      t.text :comment_text
      t.timestamps
    end
  end
end
