# frozen_string_literal: true

require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test 'visiting the index' do
    visit orders_url
    assert_selector 'h1', text: 'Orders'
  end

  test 'destroying a Order' do
    visit orders_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Order was successfully destroyed'
  end

  test 'check routing number' do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector '#order_routing_number'

    select 'Check', from: 'Pay type'

    assert_selector '#order_routing_number'

    fill_in 'Routing #', with: '123456'
    fill_in 'Account #', with: '987654'

    perform_enqueued_jobs do
      click_button 'Place Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = Order.first
    assert_equal 'Dave Thomas', order.name
    assert_equal '123 Main Street', order.address
    assert_equal 'Check', order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@example.com'], mail.to
  end

  test 'check account number' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector '#order_account_number'

    select 'Check', from: 'Pay type'

    assert_selector '#order_account_number'
  end

  test 'check credit card number' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector '#order_credit_card_number'

    select 'Credit card', from: 'Pay type'

    assert_selector '#order_credit_card_number'
  end

  test 'check credit card expiration date' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector '#order_expiration_date'

    select 'Credit card', from: 'Pay type'

    assert_selector '#order_expiration_date'
  end
end
