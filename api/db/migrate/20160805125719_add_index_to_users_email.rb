class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
    # add an index on the email column of the users table and enforce its uniqueness
    add_index :users, :email, unique: true
  end
end
