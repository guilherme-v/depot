require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "creating a Cart" do
    visit carts_url
    click_on "New Cart"

    click_on "Create Cart"

    assert_text "Cart was successfully created"
  end

  test "updating a Cart" do
    visit carts_url
    click_on "Edit", match: :first

    click_on "Update Cart"

    assert_text "Cart was successfully updated"
  end

  test "destroying a Cart" do
    visit carts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Your cart is current empty"
  end

  test 'empty Cart should also hide Cart after' do
    visit store_index_url

    page.has_no_content?('Your Cart')

    click_on 'Add to Cart', match: :first

    page.has_content?('Your Cart')

    page.accept_confirm do
      click_on 'Empty cart', match: :first
    end

    page.has_no_content?('Your Cart')
  end

  test 'should show Cart when something is added to it' do
    visit store_index_url

    page.has_no_content?('Your Cart')

    click_on 'Add to Cart', match: :first

    page.has_content?('Your Cart')
  end
end
