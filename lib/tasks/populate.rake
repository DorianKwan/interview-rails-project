require "quote"

namespace :db do
  desc "Create fake users, discussions, comments, etc in the database"
  task populate: :environment do
    puts "Creating fake users, discussions, comments, etc in the database"

    puts "Truncating tables..."
    [User, Category, Post, PostComment, CommentComment].each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table.to_s.underscore.downcase.pluralize}")
    end

    # Trim the number of records that are created to a smaller subset.
    # Userful for testing the script.
    TRIMMER = 0.01

    puts "Creating users..."
    (10_000 * TRIMMER).to_i.times do
      begin
        User.create!(
          full_name: Faker::Name.name,
          email: Faker::Internet.unique.email,
          nickname: Faker::Internet.unique.username,
          password: "testing",
          signature: Faker::Marketing.buzzwords

        )
      rescue ActiveRecord::RecordNotUnique
        # skip if email already taken
      end
    end

    puts "Creating categories..."
    categories = []
    categories << Category.create!(name: "Memes")
    categories << Category.create!(name: "Wholesome")
    categories << Category.create!(name: "NHL")
    categories << Category.create!(name: "Mindblowing")
    categories << Category.create!(name: "News")
    categories << Category.create!(name: "Photography")
    categories << Category.create!(name: "Parenting")
    categories << Category.create!(name: "Aww")
    categories << Category.create!(name: "Crypto")
    categories << Category.create!(name: "Music")
    categories << Category.create!(name: "Travel")
    categories << Category.create!(name: "Food")

    num_posts = (1_000 * TRIMMER * rand).floor
    puts "Creating #{num_posts} posts per user and comments..."

    User.all.each do |u|
      # 50% chance of this user not having any comments
      next if rand * 100 <= 50

      num_posts.floor.times do
        random_category = categories.sample
        post = Post.create!(
          created_by: u.nickname,
          category_id: random_category.id,
          title: Faker::Book.title,
          content: Quote.random,
          created_at: Time.at(rand(5.years.ago.to_i..5.days.ago.to_i)).to_datetime,
        )

        # 50% chance of this post not having any comments
        next if rand * 100 <= 33

        (50 * rand).floor.times do
          another_random_user = User.find(User.select(:id).sample.id)
          comment = PostComment.create!(
            created_by: another_random_user.nickname,
            content: Quote.random,
            created_at: Time.at(rand(5.days.ago.to_i..Time.now.to_i)).to_datetime,
            post_id: post.id
          )

          # 33% chance of this comment not having any sub comments
          next if rand * 100 <= 33

          (5 * rand).ceil.times do
            yet_another_random_user = User.find(User.select(:id).sample.id)
            CommentComment.create!(
              created_by: yet_another_random_user.nickname,
              content: Quote.random,
              created_at: Time.at(rand(5.days.ago.to_i..Time.now.to_i)).to_datetime,
              post_comment_id: comment.id
            )
          end
        end
      end
    end

    puts "Create moderators (1% of users)"
    User
      .select(:id)
      .sample((User.count * 0.01).to_i)
      .map(&:id)
      .each do |user_id|
        User.find(user_id).update!(is_moderator: true)
      end

    exit

  end
end
