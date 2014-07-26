class CreateSentimientos < ActiveRecord::Migration
  def change
    create_table :sentimientos do |t|
      t.string :sentimiento, :null => false

      t.timestamps
    end
  end
end
