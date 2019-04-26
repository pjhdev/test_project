class CreateBulletins < ActiveRecord::Migration[5.1]
  def change
    create_table :bulletins do |t|
      t.string :title, comment: '게시판 제목'
      t.text :description, comment: '게시판 설명'

      t.timestamps
    end
  end
end
