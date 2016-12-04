require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'
require 'support/features/shared_examples_for_vote_able'

RSpec.feature 'Post comments', type: :feature do
  given(:post_creator) { create(:user, name: 'John', last_name: 'Anderson') }
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given!(:post) { create(:post, user: post_creator, slug: 'test-post') }
  given!(:activity) do
    create(:activity, trackable_id: post.id, trackable_type: 'Post',
                      owner_id: post_creator.id, owner_type: 'User', key: 'post.create')
  end

  it_behaves_like 'index_page_for_commentable_resource', '/activities', '/posts/test-post'
  it_behaves_like 'show_page_for_commentable_resource',  '/posts/test-post'
  it_behaves_like 'index_page_for_vote_able_resource',   '/activities', '/posts/test-post'
  it_behaves_like 'show_page_for_vote_able_resource',    '/posts/test-post'
end
