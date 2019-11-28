require_relative "../test_helper"

class UpvotingTest < ActionDispatch::IntegrationTest
  def test_two_upvotes
    user = ::FactoryBot.create(:user)
    category = ::FactoryBot.create(:category)
    post = ::FactoryBot.create(:post, created_by: user.nickname, category_id: category.id)

    open_session do |session|
      session.post "/posts/#{post.id}/upvote", params: {}
      assert_equal 302, session.status
    end
    open_session do |session|
      session.post "/posts/#{post.id}/upvote", params: {}
      assert_equal 302, session.status
    end

    assert_equal 2, post.reload.upvotes
  end
end
