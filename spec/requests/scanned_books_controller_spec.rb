require 'rails_helper'

# vcr_options = {
#   record: :new_episodes, # See https://www.relishapp.com/vcr/vcr/v/1-6-0/docs/record-modes
#   serialize_with: :json
# }


RSpec.describe "ScannedBooksController", type: :request, vcr: vcr_options do

  let(:user) { FactoryGirl.create(:user) }
  let(:scanned_book) { FactoryGirl.create(:scanned_book) }

  before do
    login_as(user, :scope => :user)
    stubbed_requests = Faraday::Adapter::Test::Stubs.new do |stub|
      response_body = fixture('voyager-2028405.xml').read
      stub.get('/2028405') { |env| [200, {}, response_body] }
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
      source_metadata_identifier: "2028405",
      access_policy: "something",
      use_and_reproduction: "something else"
    }

    #VCR.use_cassette('good_bib_record') do
    post "/concern/scanned_books", scanned_book: valid_params
    #end

    expect(response).to redirect_to([:curation_concern, assigns(:curation_concern)])
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.status).to eq 200
    expect(response.body).to include("<h1>My Book")
  end
end
