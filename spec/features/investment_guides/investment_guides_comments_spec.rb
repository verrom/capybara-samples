require 'capybara_helper'
require 'spec_helper'
require 'support/features/shared_examples_for_commentable'

RSpec.feature 'Investment guide comments', type: :feature do
  given(:commenter) { create(:user, name: 'Simon', last_name: 'Stivens') }
  given(:country) { create(:country, title: 'Mordor', country_code: 'MR') }
  given!(:investment_guide) { create(:investment_guide, country_id: country.id) }

  it_behaves_like 'show_page_for_commentable_resource', '/countries/mordor/investment_guide'
end
