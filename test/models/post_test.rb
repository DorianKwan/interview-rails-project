require_relative "../test_helper"

class PostTest < Minitest::Test

  def test_can_upvote_a_post
    user = ::FactoryBot.create(:user)
    category = ::FactoryBot.create(:category)
    post = ::FactoryBot.create(:post, created_by: user.nickname, category_id: category.id)

    assert_equal 0, post.reload.upvotes

    post.upvote!

    assert_equal 1, post.reload.upvotes
  end

  def test_works_with_several_upvotes
    user = ::FactoryBot.create(:user)
    category = ::FactoryBot.create(:category)
    post = ::FactoryBot.create(:post, created_by: user.nickname, category_id: category.id)

    100.times do
      post.upvote!
    end

    assert_equal 100, post.reload.upvotes
  end

end

