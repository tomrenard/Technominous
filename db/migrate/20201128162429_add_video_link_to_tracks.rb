class AddVideoLinkToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :video_link, :string
  end
end
