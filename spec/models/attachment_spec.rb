require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:comment).optional }
  it { should have_one :user }
end
