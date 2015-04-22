require 'rails_helper'


RSpec.describe "ScannedBooksController", type: :request do

  let(:user) { FactoryGirl.create(:user) }

  before do
    login user
    stubbed_requests = Faraday::Adapter::Test::Stubs.new do |stub|
      response_body = fixture('voyager-2028405.xml').read
      stub.get('/123456') { |env| [200, {}, response_body] }
    end
    stubbed_connection = Faraday.new do |builder|
      builder.adapter :test, stubbed_requests
    end
    allow(Faraday).to receive(:new).with(:url => 'http://bibdata.princeton.edu/bibliographic/').and_return(stubbed_connection)
  end
  
  it "User creates a new scanned book" do
    get "/concern/scanned_books/new"
    expect(response).to render_template('curation_concern/scanned_books/new')
    valid_params = {
      title: ["My Book"],
      source_metadata_id: "123456",
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
end