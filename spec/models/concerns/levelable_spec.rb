require 'rails_helper'

RSpec.describe Levelable, type: :concern do
  # Use real User model for testing since it includes the concern
  let(:model_instance) { User.new(email: 'test@example.com', password: 'password123', level: 1, current_xp: 0) }

  describe 'validations' do
    it 'validates level is between 1 and 100' do
      model_instance.level = 0
      expect(model_instance).not_to be_valid
      expect(model_instance.errors[:level]).to include('must be greater than or equal to 1')

      model_instance.level = 101
      expect(model_instance).not_to be_valid
      expect(model_instance.errors[:level]).to include('must be less than or equal to 100')

      model_instance.level = 50
      expect(model_instance).to be_valid
    end

    it 'validates current_xp is not negative' do
      model_instance.current_xp = -1
      expect(model_instance).not_to be_valid
      expect(model_instance.errors[:current_xp]).to include('must be greater than or equal to 0')

      model_instance.current_xp = 0
      expect(model_instance).to be_valid
    end
  end

  describe '#xp_for_next_level' do
    it 'calculates XP needed for next level' do
      model_instance.level = 1
      expect(model_instance.xp_for_next_level).to eq(400) # (1+1)^2 * 100

      model_instance.level = 5
      expect(model_instance.xp_for_next_level).to eq(3600) # (5+1)^2 * 100
    end

    it 'returns 0 for max level' do
      model_instance.level = 100
      expect(model_instance.xp_for_next_level).to eq(0)
    end
  end

  describe '#xp_for_current_level' do
    it 'calculates XP threshold for current level' do
      model_instance.level = 1
      expect(model_instance.xp_for_current_level).to eq(100) # 1^2 * 100

      model_instance.level = 5
      expect(model_instance.xp_for_current_level).to eq(2500) # 5^2 * 100
    end
  end

  describe '#xp_progress' do
    it 'calculates progress within current level' do
      model_instance.level = 5
      model_instance.current_xp = 3000
      expect(model_instance.xp_progress).to eq(500) # 3000 - 2500
    end
  end

  describe '#xp_needed_for_next_level' do
    it 'calculates XP needed to reach next level' do
      model_instance.level = 5
      expect(model_instance.xp_needed_for_next_level).to eq(1100) # 3600 - 2500
    end
  end

  describe '#level_progress_percentage' do
    it 'calculates percentage progress to next level' do
      model_instance.level = 5
      model_instance.current_xp = 3050
      expect(model_instance.level_progress_percentage).to eq(50) # 550/1100 * 100
    end

    it 'returns 100 for max level' do
      model_instance.level = 100
      expect(model_instance.level_progress_percentage).to eq(100)
    end
  end

  describe '#add_xp' do
    before do
      model_instance.save!
    end

    it 'adds XP to current total' do
      model_instance.add_xp(150)
      expect(model_instance.current_xp).to eq(150)
    end

    it 'levels up when reaching threshold' do
      model_instance.add_xp(400)
      expect(model_instance.level).to eq(2)
      expect(model_instance.current_xp).to eq(400)
    end

    it 'handles multiple level ups' do
      model_instance.add_xp(1000)
      expect(model_instance.level).to eq(3)
      expect(model_instance.current_xp).to eq(1000)
    end

    it 'does not exceed max level' do
      # Create a new user with valid names to avoid update validation issues
      user = User.create!(
        email: 'maxlevel@example.com',
        password: 'password123',
        first_name: 'Max',
        last_name: 'Level',
        level: 99,
        current_xp: 980100 # 99^2 * 100
      )
      # Need to add enough XP to reach level 100: 100^2 * 100 = 1000000
      # Current XP is 980100, so need 19900 more
      user.add_xp(19900) # This should level up to 100
      expect(user.level).to eq(100)
      expect(user.current_xp).to eq(1000000)
    end
  end
end
