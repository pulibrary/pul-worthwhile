require 'rails_helper'

RSpec.feature "ScannedBooksController", type: :feature do

  let(:user) { FactoryGirl.create(:admin) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before do
    login_as(user, :scope => :user)
  end

  scenario "User can edit a scanned book" do
    visit polymorphic_path [:curation_concern, scanned_book]
    click_link 'Edit This Scanned Book'
    fill_in 'scanned_book_source_metadata_identifier', with: 'abcdef'
  end
end