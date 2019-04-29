class Post < ApplicationRecord
  belongs_to :bulletin
  # dependent: :destroy 옵션은 1:n 관계에서 1 에 포함하는 객체가 삭제될 때
  # 하위에 있는 child(여기서는 comments) 들을 모두 삭제한다는 뜻이다.
  has_many :comments, dependent: :destroy

  mount_uploader :picture, PictureUploader
  acts_as_taggable

  def tag_list_fixed
    tag_list.to_s
  end

  def tag_list_fixed=(tag_list_string)
    self.tag_list = tag_list_string
  end
end
