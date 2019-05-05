# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190505123606) do

  create_table "bulletins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title", comment: "게시판 제목"
    t.text "description", comment: "게시판 설명"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_type"
    t.integer "post_type_cd", default: 0
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "post_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "members", primary_key: "seq", id: :integer, comment: "시퀀스", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "id", limit: 20, null: false, comment: "아이디"
    t.string "pwd", limit: 100, null: false, comment: "비밀번호"
    t.integer "is_admin", null: false, comment: "관리자 여부"
    t.string "name", limit: 20, comment: "이름"
    t.string "phone_number", limit: 15, comment: "연락처"
    t.integer "student_id", comment: "학번"
    t.date "birth_day", comment: "생년월일"
    t.integer "attd_cnt", comment: "누적 참가 횟수"
    t.integer "is_worker", comment: "직장인 여부"
    t.integer "is_benefit", comment: "혜택 여부"
    t.string "profile_img", limit: 30, comment: "프로필 이미지"
    t.string "session_id", limit: 30, comment: "세션ID"
    t.datetime "session_limit", comment: "세션ID 유효 기간"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "생성일"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "수정일"
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "title", comment: "게시글 제목"
    t.text "content", comment: "게시글 내용"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bulletin_id"
    t.string "picture"
    t.index ["bulletin_id"], name: "index_posts_on_bulletin_id"
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", limit: 100
    t.string "password_digest", limit: 100
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "posts", "bulletins"
end
