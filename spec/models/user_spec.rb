require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'email' do
      u = User.new(name: 'Julia Almeida', email: 'julia@yahoo.com')
      
      result = u.valid?
      
      expect(result).to eq false
    end
  end
end
