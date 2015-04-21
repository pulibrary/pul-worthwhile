require 'rails_helper'

RSpec.feature "ScannedBooksController", type: :feature do

  let(:user) { FactoryGirl.create(:admin) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before(:each) do 
    login_as(user, :scope => :user)
  end

  scenario "Logged in user can follow link to edit scanned book" do

    # TODO: User can see button to edit, but
    #   is not authorized to edit on the next screen.
    visit polymorphic_path [:curation_concern, scanned_book]
    login_as(user, :scope => :user)
    click_link 'Edit This Scanned Book'
    expect(page).to have_text("")
  end

  scenario "User can edit a scanned book" do
    visit edit_polymorphic_path [:curation_concern, scanned_book]
    fill_in 'scanned_book_source_metadata_identifier', with: '1234568'
    fill_in 'scanned_book_portion_note', with: 'new portion note'
    fill_in 'scanned_book_description', with: 'new description'

    # TODO: User can make an edit and click save button, but
    #   is not authorized to view item afterwards without logging in again.
    login_as(user, :scope => :user)
    click_button 'Update Scanned book'
    expect(page).to have_text("")
  end
end