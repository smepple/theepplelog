class RemoveSorceryFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    remove_column :users, :salt
    rename_column :users, :crypted_password, :password_digest
  end
end
