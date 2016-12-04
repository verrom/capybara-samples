require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'
require 'support/features/shared_examples_for_vote_able'

RSpec.feature 'Related link comments', type: :feature do
  given(:link_creator) { create(:user, name: 'John', last_name: 'Anderson') }
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given!(:link) { create(:related_link, user: link_creator) }

  it_behaves_like 'index_page_for_commentable_resource', '/knowledge_hubs/links',
                  '/knowledge_hubs/links/mystring'
  it_behaves_like 'show_page_for_commentable_resource',  '/knowledge_hubs/links/mystring'
  it_behaves_like 'index_page_for_vote_able_resource',   '/knowledge_hubs/links',
                  '/knowledge_hubs/links/mystring'
  it_behaves_like 'show_page_for_vote_able_resource',    '/knowledge_hubs/links/mystring'
end
