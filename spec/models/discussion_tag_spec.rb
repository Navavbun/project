require "rails_helper"

RSpec.describe DiscussionTag, type: :model do
  describe "associations" do
    it { should belong_to(:discussion) }
    it { should belong_to(:tag) }
  end
end
