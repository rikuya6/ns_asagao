class CreateMemberImages < ActiveRecord::Migration
  def change
    create_table :member_images do |t|
      t.references  :member,        null: false
      t.binary      :data,          null: false
      t.string      :content_type,  null: false

      t.timestamps                  null: false
    end

    add_index :member_images, :member_id
  end
end
