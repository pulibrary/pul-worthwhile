# Generated via
#  `rails generate worthwhile:work ScannedBook`
require 'rails_helper'

describe ScannedBook do

  let(:subject) {
    s = ScannedBook.new
    s.src_metadata_id  = "12345"
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
      subject.src_metadata_id = id
      expect { subject.save }.to_not raise_error
      subject.reload
      expect(subject.src_metadata_id).to eq id
    end

    it "should require me to set a metadata id" do
      subject.src_metadata_id = nil
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
end
