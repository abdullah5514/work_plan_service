require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:worker_id) }
    it { should belong_to(:worker) }

    it 'should be 8 hours long' do
      worker = FactoryBot.create(:worker)
      start_time = Time.now.beginning_of_day + 8.hours
      end_time = start_time + 9.hours
      shift = FactoryBot.build(:shift, worker: worker, start_time: start_time, end_time: end_time)
      expect(shift.valid?).to be_falsey
    end

    it 'should have start time in the 24-hour timetable' do
        worker = FactoryBot.create(:worker)
        
        # Invalid start time (less than 0)
        shift = FactoryBot.build(:shift, worker: worker, start_time: Time.current.beginning_of_day - 1.hour)
        expect(shift.valid?).to be_falsey
      
        # Valid start time (0)
        shift = FactoryBot.build(:shift, worker: worker, start_time: Time.current.beginning_of_day, end_time: Time.current.beginning_of_day + 8.hours)
        # binding.break
        expect(shift.valid?).to be_truthy
      
        # Valid start time (8)
        shift = FactoryBot.build(:shift, worker: worker, start_time: Time.current.beginning_of_day + 8.hours, end_time: Time.current.beginning_of_day + 16.hours)
        expect(shift.valid?).to be_truthy
      
        # Valid start time (16)
        shift = FactoryBot.build(:shift, worker: worker, start_time: Time.current.beginning_of_day + 16.hours, end_time: Time.current.beginning_of_day + 24.hours)
        expect(shift.valid?).to be_truthy
      
        # Invalid start time (greater than or equal to 24)
        shift = FactoryBot.build(:shift, worker: worker, start_time: Time.current.beginning_of_day + 23.hours, end_time: Time.current.beginning_of_day + 32.hours)
        expect(shift.valid?).to be_falsey
      end

    it 'should have end time in the 24-hour timetable' do
      worker = FactoryBot.create(:worker)
      start_time = Time.now.beginning_of_day + 8.hours
      end_time = start_time + 10.hours
      shift = FactoryBot.build(:shift, worker: worker, start_time: start_time, end_time: end_time)
      expect(shift.valid?).to be_falsey
    end
  end
end