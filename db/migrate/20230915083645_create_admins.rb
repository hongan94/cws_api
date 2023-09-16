class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :fullname
      t.string :phone
      t.string :email
      t.string :password_digest
      t.integer :gender
      t.string :address

      t.timestamps
    end
  end
end
