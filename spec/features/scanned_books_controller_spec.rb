require 'rails_helper'


RSpec.feature "ScannedBooksController", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before do
    login user
  end

  scenario "User can edit a scanned book" do
    visit polymorphic_path [:curation_concern, scanned_book]

    fill_in

    new_params = {
      title: ["New Title"],
      source_metadata_identifier: "1234567",
      access_policy: "new policy", 
      use_and_reproduction: "new use"
    }


    
    
    post "/concern/scanned_books", id: scanned_book.id, scanned_book: new_params
    follow_redirect!
    byebug
    # expect(response).to redirect_to([:curation_concern, assigns(:curation_concern)])
    # follow_redirect!

  end
end