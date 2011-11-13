class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
