require "rails_helper"

RSpec.describe Discussion, type: :model do
  describe "associations" do
    it { should have_many(:discussion_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:discussion_tags) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:topic) }
    it { should validate_presence_of(:description) }
  end
end
