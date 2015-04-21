require 'rails_helper'

RSpec.describe "ScannedBooksController", type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before do
    login_as(user, :scope => :user)
  end
  
  it "User creates a new scanned book" do
    get "/concern/scanned_books/new"
    expect(response).to render_template('curation_concern/scanned_books/new')
    valid_params = {
      title: ["My Book"],
      source_metadata_identifier: "1234567",
      access_policy: "something", 
      use_and_reproduction: "something else"
    }

    post "/concern/scanned_books", scanned_book: valid_params
    
    expect(response).to redirect_to([:curation_concern, assigns(:curation_concern)])
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.status).to eq 200
    expect(response.body).to include("<h1>My Book")
  end

  it "User edits a scanned book" do
    new_params = {
      title: ["New Title"],
      source_metadata_identifier: "1234567",
      access_policy: "new policy", 
      use_and_reproduction: "new use"
    }
    get polymorphic_path [:curation_concern, scanned_book]
    byebug
    # post "/concern/scanned_books", id: scanned_book.id, scanned_book: new_params
    # follow_redirect!
  end
end