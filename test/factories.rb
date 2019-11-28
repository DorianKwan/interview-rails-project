FactoryBot.define do

  factory :user do
    full_name { "Budgie Burrito" }
    sequence(:email) { |n| "budgie#{n}@gmail.com" }
    sequence(:nickname) { |n| "budgie#{n}" }
    password { "test123" }
    signature { "sig" }
    is_moderator { false }
  end

  factory :moderator, class: User do
    full_name { "Molly Moderator" }
    sequence(:email) { |n| "molly#{n}@gmail.com" }
    sequence(:nickname) { |n| "molly#{n}" }
    password { "test123" }
    signature { "sig" }
    is_moderator { true }
  end

  factory :category do
    name { "Category 1" }
  end

  # fill in:
  # - created_by
  # - category_id
  factory :post do
    title { "Title" }
    content { "This is the post content." }
  end

  # fill in:
  # - created_by
  # - post_id
  factory :post_comment do
    content { "This is the post comment content" }
  end

  # fill in:
  # - created_by
  # - post_comment_id
  factory :comment_comment do
    content { "This is the comment content" }
  end

end
