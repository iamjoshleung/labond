require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(26) }
  it { should have_many(:posts).through(:post_topics) }
  it { should validate_uniqueness_of(:name) }
end
