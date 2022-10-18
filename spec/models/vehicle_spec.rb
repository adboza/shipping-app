require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when licence_plate is empty' do
       
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: '', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: 300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end
      
      it 'false when year is empty' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: nil, vehicle_type: type, model: 'Fusca', load_capacity: 300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when vehicle_type is empty' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: nil, model: 'Fusca', load_capacity: 300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when load_capacity is empty' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: nil)
       
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when load capacity is not bigger than zero' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: -300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when load capacity is not numeric field' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: 'a')
       
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when licence plate is not unique' do
        
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        Vehicle.create!(licence_plate: 'ABC1100', status: :available, year: 1.year.ago, vehicle_type: type, model: 'Fusca', load_capacity: 360)
        vehicle = Vehicle.new(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: 300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end

      it 'false when licence plate is not 7 digits long' do
       
        type = VehicleType.create!(vehicle_type: :utility_vehicle)
        vehicle = Vehicle.new(licence_plate: 'ABC100', status: :unavailable, year: 2.days.ago, vehicle_type: type, model: 'Fusca', load_capacity: 300)
        
        result = vehicle.valid?
        
        expect(result).to eq false
      end
    end
  end
end
