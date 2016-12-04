require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'
require 'support/features/shared_examples_for_vote_able'

RSpec.feature 'Policy comments', type: :feature do
  given(:policy_creator) { create(:user, name: 'John', last_name: 'Anderson') }
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given!(:policy) { create(:policy, user: policy_creator) }

  it_behaves_like 'index_page_for_commentable_resource', '/knowledge_hubs/policy',
                  '/knowledge_hubs/policy/mystring'
  it_behaves_like 'show_page_for_commentable_resource',  '/knowledge_hubs/policy/mystring'
  it_behaves_like 'index_page_for_vote_able_resource',   '/knowledge_hubs/policy',
                  '/knowledge_hubs/policy/mystring'
  it_behaves_like 'show_page_for_vote_able_resource',    '/knowledge_hubs/policy/mystring'
end
