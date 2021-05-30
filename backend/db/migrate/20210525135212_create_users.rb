class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password, null: false
      t.integer :role, null: false, default: 1
      t.integer :active, null: false, default: 1
      t.datetime :deleted_at
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.index :email, unique: true
    end
  end
end
