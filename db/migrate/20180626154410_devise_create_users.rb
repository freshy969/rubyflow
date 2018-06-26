# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Github profile
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :profile_url, null: false

      t.timestamps null: false
    end
  end
end
