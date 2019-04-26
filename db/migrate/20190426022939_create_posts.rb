class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, comment: "게시글 제목"
      t.text :content, comment: "게시글 내용"

      t.timestamps
    end
  end
end
