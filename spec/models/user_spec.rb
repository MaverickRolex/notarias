require 'rails_helper'

RSpec.describe User, type: :model do

  describe "asociations" do
    it { should have_many(:procedures).class_name('Procedure').with_foreign_key('creator_user') }
    it { should have_many(:user_preferences) }
    it { should have_many(:preferences).through(:user_preferences) }
    it { should have_many(:permissions) }
    it { should have_many(:user_groups) }
    it { should have_many(:groups).through(:user_groups) }
    it { should have_many(:prep_processes) }
    it { should have_many(:segments).through(:prep_processes) }
  end

  describe "validations" do
    it { expect(build(:user)).to be_valid }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to_not allow_value('unemail@mail.com').for(:username) }
  end

  describe "before_validation" do
    it { is_expected.to callback(:set_username).before(:validation) }
  end

  describe "attr_accessors" do
    it { expect have_attr_accessor(:login) }
    it { expect have_attr_accessor(:prevalidate_username_uniqueness) } # ahi se lo pones tu al context
  end
  
  describe "#set_username" do
    context "when prevalidate_username_uniqueness = true" do
      it "sets a username if it's blank" do
        user = build(:user, username: "", prevalidate_username_uniqueness: true)
        expect { user.save }.to change { user.username }
      end

      it "returns a new username if the username already exists" do
        username = "username1"
        user = create(:user, username: username)
        user2 = build(:user, username: username, prevalidate_username_uniqueness: true)
        user2.save
        expect(user2.username).to_not eq(user.username)
      end
    end

    context "when prevalidate_username_uniqueness = false" do
      it "doesn't change the username" do
        username_string = "username"
        user1 = create(:user, username: username_string)
        user2 = build(:user, username: username_string)
        expect { user2.save }.not_to change { user2.username }
      end
    end 
  end

  #These tests are for the devise behavior, 
  #the instance form User to evaluate, 
  #has to be new, not a record saved in 
  #the database or it will never be saved in 
  #cases that are not sent or the username or email.
  describe "#login" do
    it "returns username" do
      user = create(:user)
      expect(user.login).to eq(user.username)
    end

    context "when user is a new record" do
      it "returns email if username and login attributes are nil" do
        user = build(:user, email: "email", username: nil)
        expect(user.login).to eq(user.email)
      end

      it "returns username if login attribute is nil" do
        user = build(:user, email: nil, username: "username")
        expect(user.login).to eq(user.username)
      end

      it "returns login if it isn’t nil because of conditional precedence" do
        user = build(:user, email: nil, username: nil, login: "login")
        expect(user.login).to eq("login")
      end
    end
  end
end