# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :note
      t.datetime :time_start
      t.datetime :time_complete
      t.boolean :is_complete, default: false

      t.timestamps
    end
  end
end
