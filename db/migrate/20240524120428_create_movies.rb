class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :original_title
      t.string :original_language
      t.date :release_date
      t.text :overview
      t.string :poster_url
      t.float :rating

      t.timestamps
    end
  end
end
