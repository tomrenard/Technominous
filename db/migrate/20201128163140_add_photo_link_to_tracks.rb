class AddPhotoLinkToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :photo_link, :string
  end
end
