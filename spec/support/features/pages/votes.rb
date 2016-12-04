require 'capybara_helper'
require 'support/feature_helpers'

module Pages
  class Votes
    include RSpec::Matchers
    include Capybara::DSL

    def vote_resource
      within_vote_button { click_link 'Like' }
    end

    def try_vote_resource
      find('.vote-number').click
    end

    def has_item_text?(text)
      within_item_block { expect(page).to have_text(text) }
    end

    def has_votes_count_changed_on_show_page?
      within_vote_button { expect(page).to have_text('unlike (1)') }
    end

    def has_votes_count_changed_in_the_item?
      within_item_block { expect(page).to have_text('1 likes') }
    end

    private

    def within_item_block
      within('.n-list-item') do
        yield
      end
    end

    def within_vote_button
      within('.vote-button') do
        yield
      end
    end
  end
end
