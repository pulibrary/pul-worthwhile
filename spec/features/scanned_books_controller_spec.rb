require 'rails_helper'

RSpec.feature "ScannedBooksController", type: :feature do

  let(:user) { FactoryGirl.create(:admin) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before(:each) do
    sign_in user
  end

  scenario "Logged in user can follow link to edit scanned book" do
    visit polymorphic_path [:curation_concern, scanned_book]
    click_link 'Edit This Scanned Book'
    expect(page).to have_text('Manage Your Work')
  end

  scenario "User can edit a scanned book" do
    visit edit_polymorphic_path [:curation_concern, scanned_book]
    fill_in 'scanned_book_source_metadata_identifier', with: '1234568'
    fill_in 'scanned_book_portion_note', with: 'new portion note'
    fill_in 'scanned_book_description', with: 'new description'
    click_button 'Update Scanned book'
    expect(page).to have_text("Test title (Scanned Book)")
  end
end
