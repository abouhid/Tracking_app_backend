# spec/models/Measure_spec.rb
require 'rails_helper'

# Test suite for the Measure model
RSpec.describe Measure, type: :model do
  # Association test
  # ensure an Measure record belongs to a single todo record
  it { should belong_to(:measurement) }
  # Validation test
  # ensure column type is present before saving
  it { should validate_presence_of(:type_of_measure) }
end