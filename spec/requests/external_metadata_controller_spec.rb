require 'rails_helper'

RSpec.describe ExternalMetadataController, :type => :request do

  voyager = '{"id":"123","source":"voyager","original_uri":"http://mybook.princeton.edu/121123234","fields":{"title":"Voyager thing","publisher":"A publisher"}}'
  ead = '{"id":"ead_234","source":"ead","original_uri":"http://myead.princeton.edu/AC230_00002","fields":{"title":"EAD Thing","publisher":"A publisher"}}'
  before do
    #login_as(user, :scope => :user)
    stubbed_requests = Faraday::Adapter::Test::Stubs.new do |stub|
      response_body = fixture('voyager-2028405.xml').read
      stub.get('/metadata/20228405') { |env| [200, {}, voyager] }
      stub.get('/metadata/AC301_0001') { |env| [200, {}, ead] }
    end
    stubbed_connection = Faraday.new do |builder|
      builder.adapter :test, stubbed_requests
    end
    allow(Faraday).to receive(:new).with(:url => "#{root_url}metadata/").and_return(stubbed_connection)
  end

  it "responds to json" do
    get "/metadata/2028405"
    expect(response.status).to eq 200
    expect(response["Content-Type"]).to eq('application/json; charset=utf-8')
  end

  it "Shows the result for a Voyager ID" do
    get "/metadata/2028405"
    expect(response.status).to eq 200
    response_json = JSON.parse(response.body)
    expect(response_json['source']).to eq('voyager')
    expect(response_json['fields']).to be_truthy
  end

  it "Shows the result for a Pulfa ID" do
    get "/metadata/AC301_0001"
    expect(response.status).to eq 200
    response_json = JSON.parse(response.body)
    expect(response_json['source']).to eq('ead')
    expect(response_json['fields']).to be_truthy
  end

end
