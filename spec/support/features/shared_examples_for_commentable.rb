require 'rails_helper'

RSpec.shared_examples 'show_page_for_commentable_resource' do |path|
  describe 'Show page' do
    context 'When user signed in' do
      before do
        sign_in commenter
        visit path
      end

      scenario "Check comments count when it's empty" do
        comment_page = Pages::Comments.new
        expect(comment_page).to have_item_text('comments (0)')
      end

      scenario 'Add comment to resource', js: true do
        add_comment_to_resource 'MyComment'
        expect(page).to have_text('MyComment')
        expect(page).to have_text('comments (1)')
      end

      scenario 'Comment has link to user profile', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        comment_page.click_commenter_name

        expect(comment_page).to have_title 'Simon Stivens'
      end

      scenario 'Comment has creation date', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        click_link 'comments (1)'

        expect(comment_page).to have_createon_date 'January 01, 2016'
      end

      scenario 'User can update his comment after page reloading', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        visit path
        comment_page.update_comment_with 'updated comment'

        expect(page).to have_text('updated comment')
      end

      scenario 'User can update his comment to the resource', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        comment_page.update_comment_with 'updated comment'

        expect(page).to have_text('updated comment')
      end

      scenario 'User can delete his comment', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        comment_page.delete_comment

        expect(page).to have_text('Your comment has been deleted.')
      end

      scenario 'User can update 7th comment', js: true do
        comment_page = Pages::Comments.new
        add_comment_to_resource
        5.times do
          comment_page.add_one_more_comment
        end
        add_comment_to_resource 'last comment'

        visit path
        click_on 'comments (7)'
        click_on 'see more'

        expect(page).to have_text('last comment')
        comment_page.update_last_comment
      end
    end

    context 'When user does not signed in' do
      before do
        visit path
      end

      scenario "User can't post comments", js: true do
        comment_page = Pages::Comments.new
        click_on 'comments (0)'
        expect(comment_page).
          to have_notify_block('You have to sign in or sign up to post comments.')
      end
    end
  end
end

RSpec.shared_examples 'index_page_for_commentable_resource' do |index_page, show_page|
  describe 'Index page' do
    scenario "Item has comments count when it's empty" do
      visit index_page
      comment_page = Pages::Comments.new
      expect(comment_page).to have_item_text('0 comments')
    end

    scenario "Item has comments count when it's not empty", js: true do
      sign_in commenter
      visit show_page
      comment_page = Pages::Comments.new
      add_comment_to_resource 'MyComment'
      visit index_page

      expect(comment_page).to have_item_text('1 comments')
    end
  end
end
