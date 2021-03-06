class CatColumns < ActiveRecord::Migration
  def up
    add_column :cats, :guid, :string
    add_column :cats, :image, :string
    add_column :cats, :title, :string
    add_index :cats, :guid, :unique => true
  end

  def down
    remove_column :cats,:guid
    remove_column :cats,:image
    remove_column :cats,:title
  end
end
