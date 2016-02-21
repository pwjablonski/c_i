class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :github_repo_url

      t.timestamps null: false
    end
  end
end
