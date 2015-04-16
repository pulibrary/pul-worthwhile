# Generated via
#  `rails generate worthwhile:work ScannedBook`
require 'rails_helper'

describe ScannedBook do

  let(:subject) {
    s = ScannedBook.new
    s.source_metadata_id  = "12345"
    s.access_policy = "Policy"
    s.use_and_reproduction = "Statement"
    s
  }

  describe 'has note fields' do

    [:portion_note, :description].each  do |note_type|
      it "should let me set a #{note_type}" do
        note = 'This is note text'
        subject.send("#{note_type}=", note)
        expect { subject.save }.to_not raise_error
        subject.reload
        expect(subject.send(note_type)).to eq note
      end
    end
  end

  describe 'has source metadata id' do
    it "should let me set a metadata id" do
      id = "12345"
      subject.source_metadata_id = id
      expect { subject.save }.to_not raise_error
      subject.reload
      expect(subject.source_metadata_id).to eq id
    end

    it "should require me to set a metadata id" do
      subject.source_metadata_id = nil
      expect(subject.valid?).to be_falsey
    end
  end

  describe 'has policy fields' do

    # TODO: Set by policy key and test by value
    [:access_policy, :use_and_reproduction].each  do |policy_type|
      it "should let me set a #{policy_type}" do
        policy = 'This is a policy'
        subject.send("#{policy_type}=", policy)
        expect { subject.save }.to_not raise_error
        subject.reload
        expect(subject.send(policy_type)).to eq policy
      end

      it "should require me to set a #{policy_type}" do
        subject.send("#{policy_type}=", nil)
        expect(subject.valid?).to be_falsey
      end
    end
  end  

  describe "pulfa connection" do
    it "has the right url" do
      expect(subject.pulfa_connection.url_prefix.to_s).to eq('http://findingaids.princeton.edu/collections/')
    end
  end

  describe "bibdata connection" do
    it "has the right url" do
      expect(subject.bibdata_connection.url_prefix.to_s).to eq('http://bibdata.princeton.edu/bibliographic/')
    end
  end

  describe "With a Pulfa ID" do

    before do
      stubbed_requests = Faraday::Adapter::Test::Stubs.new do |stub|
        response_body = fixture('pulfa-AC123_c00004.xml').read
        stub.get('/AC123/c00004.xml?scope=record') { |env| [200, {}, response_body] }
      end
      stubbed_connection = Faraday.new do |builder|
        builder.adapter :test, stubbed_requests
      end
      subject.source_metadata_id = 'AC123_c00004'
      allow(subject).to receive(:pulfa_connection).and_return(stubbed_connection)
    end
    
    it "Gets Data from PULFA" do
      expect(subject.pulfa_connection).to receive(:get).with('AC123/c00004.xml?scope=record').and_return(double(:body => fixture('pulfa-AC123_c00004.xml').read)) 
      subject.apply_external_metadata
    end

    it "Extracts Pulfa Metadata and full source" do
      subject.apply_external_metadata
      expect(subject.title.first).to eq("Series 1: University Librarian Records - Subseries 1A, Frederic Vinton - Correspondence")
      expect(subject.creator.first).to eq("Princeton University. Library. Dept. of Rare Books and Special Collections")
      expect(subject.publisher.first).to eq("Princeton University. Library. Dept. of Rare Books and Special Collections")
      expect(subject.date_created.first).to eq("1734-2012")
      expect(subject.source_metadata).to eq(fixture('pulfa-AC123_c00004.xml').read)
    end

  end

  describe "With a Voyager ID" do

    before do
      stubbed_requests = Faraday::Adapter::Test::Stubs.new do |stub|
        response_body = fixture('voyager-2028405.xml').read
        stub.get('/2028405') { |env| [200, {}, response_body] }
      end
      stubbed_connection = Faraday.new do |builder|
        builder.adapter :test, stubbed_requests
      end
      subject.source_metadata_id = "2028405"
      allow(subject).to receive(:bibdata_connection).and_return(stubbed_connection)
    end

    it "Gets data from Voyager" do
      expect(subject.bibdata_connection).to receive(:get).with('2028405').and_return(double(:body => fixture('voyager-2028405.xml').read)) 
      subject.apply_external_metadata
    end

    it "Extracts Voyager Metadata" do
      subject.apply_external_metadata
      expect(subject.title).to eq(["The Giant Bible of Mainz; 500th anniversary, April fourth, fourteen fifty-two, April fourth, nineteen fifty-two."])
      expect(subject.creator).to eq(["Miner, Dorothy Eugenia."])
      expect(subject.date_created).to eq(["1952"])
      expect(subject.publisher).to eq(["Fake Publisher"])
      expect(subject.source_metadata).to eq(fixture('voyager-2028405.xml').read)
    end

  end

  # it "Validates the ID as either a Pulfa or Voyager ID" do

  # end
end
