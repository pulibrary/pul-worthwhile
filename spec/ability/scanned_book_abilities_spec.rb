require 'rails_helper'
require "cancan/matchers"

describe "User" do
  describe "Abilities" do
    subject { Ability.new(current_user) }

    let(:scanned_book) { FactoryGirl.create(:scanned_book) }
    let(:user) { FactoryGirl.create(:user) }

    describe 'without embargo' do
      describe 'as a scanned book creator' do
        # let(:creating_user) { user }
        # let(:current_user) { user }
        # it {
        #   should be_able_to(:create, ScannedBook.new)
        #   should be_able_to(:read, scanned_book)
        #   should be_able_to(:update, scanned_book)
        #   should_not be_able_to(:destroy, scanned_book)
        # }
      end

      describe 'as an admin' do
        # let(:manager_user) { FactoryGirl.create(:admin) }
        # let(:creating_user) { user }
        # let(:current_user) { manager_user }
        # it {
        #   should be_able_to(:create, ScannedBook.new)
        #   should be_able_to(:read, scanned_book)
        #   should be_able_to(:update, scanned_book)
        #   should be_able_to(:destroy, scanned_book)
        # }
      end

      describe 'as a campus user' do
        # let(:creating_user) { FactoryGirl.create(:user) }
        # let(:current_user) { user }
        # it {
        #   should_not be_able_to(:create, ScannedBook.new)
        #   should be_able_to(:read, scanned_book)
        #   should_not be_able_to(:update, scanned_book)
        #   should_not be_able_to(:destroy, scanned_book)
        # }
      end

      describe 'a guest user' do
        # DEPENDS on restrictions on the ScannedBook, but normally:
        # let(:creating_user) { FactoryGirl.create(:user) }
        # let(:current_user) { nil }
        # it {
        #   should_not be_able_to(:create, ScannedBook.new)
        #   should be_able_to(:read, scanned_book)
        #   should_not be_able_to(:update, scanned_book)
        #   should_not be_able_to(:destroy, scanned_book)
        # }
      end
    end
  end
end
