class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.integer :user_id, null: false
      t.text :token, null: false
      t.text :refresh_token
      t.datetime :expired_date, null: false
      t.datetime :deleted_at
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
