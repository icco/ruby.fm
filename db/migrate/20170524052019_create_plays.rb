class CreatePlays < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :plays, id: :uuid do |t|
      t.date :bucket, null: false, index: true
      t.integer :total, null: false, default: 0

      t.belongs_to :episode, index: true, null: false, type: :uuid

      t.timestamps null: false
    end
  end

  def down
    drop_table :plays
    disable_extension 'pgcrypto' if extension_enabled?('pgcrypto')
  end
end
