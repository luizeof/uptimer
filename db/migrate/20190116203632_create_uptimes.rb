class CreateUptimes < ActiveRecord::Migration[5.2]
  def change
    create_table :uptimes do |t|
      t.integer :code

      t.timestamps
    end
  end
end
