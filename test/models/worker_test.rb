require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  test '#shift_on_date? returns true when worker has a shift on a given date' do
    worker = create(:worker)
    shift = create(:shift, worker: worker, start_time: Time.new(2022, 4, 1, 8, 0, 0), end_time: Time.new(2022, 4, 1, 16, 0, 0))
    worker_shifts_mock = Minitest::Mock.new
    worker_shifts_mock.expect(:on_date, [shift], [Date.new(2022, 4, 1)])
    worker.stub(:shifts, worker_shifts_mock) do
      result = worker.shift_on_date?(Date.new(2022, 4, 1))
      assert_equal true, result
    end
    worker_shifts_mock.verify
  end

  test '#shift_on_date? returns false when worker does not have a shift on a given date' do
    worker = create(:worker)
    worker_shifts_mock = Minitest::Mock.new
    worker_shifts_mock.expect(:on_date, [], [Date.new(2022, 4, 1)])
    worker.stub(:shifts, worker_shifts_mock) do
      result = worker.shift_on_date?(Date.new(2022, 4, 1))
      assert_equal false, result
    end
    worker_shifts_mock.verify
  end
end
