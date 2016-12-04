require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'
require 'support/features/shared_examples_for_vote_able'

RSpec.feature 'Capacity predictions comments', type: :feature do
  given(:prediction_creator) { create(:user, name: 'John', last_name: 'Anderson') }
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given!(:prediction) { create(:capacity_prediction, user: prediction_creator) }

  it_behaves_like 'index_page_for_commentable_resource', '/knowledge_hubs/predictions',
                  '/knowledge_hubs/predictions/capacity-prediction-title'
  it_behaves_like 'show_page_for_commentable_resource',
                  '/knowledge_hubs/predictions/capacity-prediction-title'
  it_behaves_like 'index_page_for_vote_able_resource', '/knowledge_hubs/predictions',
                  '/knowledge_hubs/predictions/capacity-prediction-title'
  it_behaves_like 'show_page_for_vote_able_resource',
                  '/knowledge_hubs/predictions/capacity-prediction-title'
end
