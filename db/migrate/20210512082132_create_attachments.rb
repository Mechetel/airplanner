class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string     :file
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
