require 'rails_helper'

RSpec.describe User do
  context "associates" do
    it { should have_many(:questions) }
    it { should have_many(:answers) }
  end

  context "validation" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context "author_of?" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:question) { create(:question, author: user) }

    it "author item" do
      expect(user).to be_author_of(question)
    end

    it "another user item" do
      expect(user).to be_author_of(another_question)
    end
  end
end
