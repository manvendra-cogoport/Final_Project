class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user
      t.string :article_title
      t.text :article_text
      t.string :article_image
      t.date :article_date
      t.integer :no_of_likes
      t.interger :no_of_comments
      t.timestamps
    end
  end
end
