class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :icon
      t.string :link_to
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Message.create_translation_table! :title => :string, :body => :string
      end

      dir.down do
        Message.drop_translation_table!
      end
    end
  end
end
