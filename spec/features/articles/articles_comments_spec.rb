require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'
require 'support/features/shared_examples_for_vote_able'

RSpec.feature 'Articles comments', type: :feature do
  given(:article_creator) { create(:user, name: 'John', last_name: 'Anderson') }
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given!(:article) { create(:article, user: article_creator) }
  given!(:activity) do
    create(:activity, trackable_id: article.id, trackable_type: 'Article',
                      owner_id: article_creator.id, owner_type: 'User', key: 'article.create')
  end

  it_behaves_like 'index_page_for_commentable_resource', '/activities', '/articles/mystring'
  it_behaves_like 'show_page_for_commentable_resource',  '/articles/mystring'
  it_behaves_like 'index_page_for_vote_able_resource',   '/activities', '/articles/mystring'
  it_behaves_like 'show_page_for_vote_able_resource',    '/articles/mystring'
end
