require 'rails_helper'

RSpec.describe Worker, type: :model do
  subject { described_class.new(name: 'John Doe') }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should have_many(:shifts) }

    it 'should not have two shifts on the same day' do
      worker = FactoryBot.create(:worker)
      FactoryBot.create(:shift, worker: worker, start_time: '2023-03-30T08:00:00.000Z', end_time: '2023-03-30T16:00:00.000Z')
      shift = FactoryBot.build(:shift, worker: worker, start_time: '2023-03-30T16:00:00.000Z', end_time: '2023-03-30T24:00:00.000Z')
      expect(shift.valid?).to be_falsey
    end
  end
end