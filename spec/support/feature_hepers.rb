module FeatureHelpers
  def fill_autocomplete(css_selector, options = {})
    find(css_selector).send_keys options[:with]
    wait_for { expect(page).to have_css('.pac-item', text: options[:select], visible: false) }
    page.evaluate_script("$('.pac-container').show();")
    find('.pac-item', text: options[:select]).click
    expect(find_field('Address').value).to have_content options[:select]
    sleep 2
  end

  def add_comment_to_resource(text = 'MyComment')
    click_on 'comments (0)'
    wait_for { expect(page).to have_selector(:link_or_button, 'Add Comment') }
    click_on 'Add Comment'
    fill_in 'comment[content]', with: text
    click_on 'Post comment'
  end

  def check_like_unlike_feature
    within('.vote-button') do
      expect(page).to have_text('like (0)')

      click_link 'Like'
      wait_for { expect(page).to have_text('unlike (1)') }

      click_link 'Unlike'
      wait_for { expect(page).to have_text('like (0)') }
    end
  end
end
