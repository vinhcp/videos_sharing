class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :youtube_url
      t.string :youtube_embed_url
      t.string :youtube_title
      t.text :youtube_description
      t.references :user

      t.timestamps
    end
  end
end
