class Bulletin < ApplicationRecord
  has_many :posts, dependent: :destroy
  #enum enum_post_type: {bulletin: PostType::BULLETIN, blog: PostType::BLOG, gallery: PostType::GALLERY}
  as_enum :post_type, {bulletin: PostType::BULLETIN, blog: PostType::BLOG, gallery: PostType::GALLERY}
end
