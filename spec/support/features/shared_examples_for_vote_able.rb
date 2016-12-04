RSpec.shared_examples 'show_page_for_vote_able_resource' do |path|
  describe 'Show page' do
    context 'When user signed in' do
      before do
        sign_in commenter
        visit path
      end

      scenario 'User can vote resource', js: true do
        vote_feature
        expect(page).to have_text('unlike (1)')
      end

      scenario 'User can unvote resource', js: true do
        vote_feature
        expect(page).to have_text('unlike (1)')

        unvote_feature
        expect(page).to have_text('like (0)')
      end
    end

    context 'When user does not signed in' do
      before do
        visit path
      end

      scenario "User can't vote resource", js: true do
        vote_page = Pages::Votes.new
        vote_page.try_vote_resource
        expect(page).to have_text '(0)'
      end
    end
  end
end

RSpec.shared_examples 'index_page_for_vote_able_resource' do |index_page, show_page|
  describe 'Index page' do
    scenario "Item has votes count when it's empty", js: true do
      visit index_page
      vote_page = Pages::Votes.new
      expect(vote_page).to have_item_text('0 likes')
    end

    scenario "Item has votes count when it's not empty", js: true do
      sign_in commenter
      visit show_page
      vote_page = Pages::Votes.new
      vote_page.vote_resource
      expect(vote_page).to have_votes_count_changed_on_show_page

      visit index_page

      expect(vote_page).to have_votes_count_changed_in_the_item
    end
  end
end
