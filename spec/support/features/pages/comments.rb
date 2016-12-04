require 'capybara_helper'
require 'support/feature_helpers'

module Pages
  class Comments
    include RSpec::Matchers
    include Capybara::DSL

    def click_commenter_name
      within_comment_block do
        click_link 'Simon Stivens'
      end
    end

    def has_title?(user_name)
      expect(page).to have_css('.pg-header-title', text: user_name)
    end

    def has_createon_date?(date)
      within_comment_block do
        expect(page).to have_text(date)
      end
    end

    def update_comment_with(new_comment)
      click_link 'comments (1)'
      within_comment_block do
        click_link 'Edit'
        fill_in 'comment[content]', with: new_comment
      end

      click_on 'Update comment'
    end

    def delete_comment
      within_comment_block { click_link 'Delete' }
    end

    def has_notify_block?(notification)
      within('.notify-block') do
        expect(page).to have_text(notification)
      end
    end

    def has_item_text?(text)
      within_item_block { expect(page).to have_text(text) }
    end

    def add_comment_to_resource(text = 'MyComment')
      click_on 'comments (0)'
      wait_for { expect(page).to have_selector(:link_or_button, 'Add Comment') }
      click_on 'Add Comment'
      fill_in 'comment[content]', with: text
      click_on 'Post comment'
    end

    def add_one_more_comment(text = 'MyComment')
      expect(page).to have_field('comment[content]')
      fill_in 'comment[content]', with: text
      wait_for { expect(find_field('comment[content]').value).to have_text text }
      click_on 'Post comment'
      sleep 1
    end

    def update_last_comment
      within all('.t-comment').last do
        click_link 'Edit'
        fill_in 'comment[content]', with: 'updated comment'
      end

      click_on 'Update comment'
      expect(page).to have_text('updated comment')
    end

    private

    def within_comment_block
      within('.t-comment') do
        yield
      end
    end

    def within_item_block
      within('.n-list-item') do
        yield
      end
    end
  end
end
