class CreateHomes < ActiveRecord::Migration[5.2]
  def change
    create_table :homes do |t|

      t.string :title
      t.string :opinion
      t.text :body
      t.timestamps
    end
  end
end
