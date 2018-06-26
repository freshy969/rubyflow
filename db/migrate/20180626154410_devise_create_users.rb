# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Github profile
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :profile_url, null: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
