class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :worker_id, presence: true
  
  validate :shift_length, :no_overlapping_shifts
  validate :start_time_within_timetable

  def start_time_within_timetable
    if start_time.present? && !([0, 8, 16].include?(start_time.to_datetime.hour))
      errors.add(:start_time, "must be within the 24-hour timetable of 0-8, 8-16, 16-24")
    end
  end

  def shift_length
    if start_time.present? && end_time.present? && (end_time - start_time) != 8.hours
      errors.add(:end_time, "Shift must be 8 hours long")
    end
  end

  def no_overlapping_shifts
    if worker && worker.shifts.where('date(start_time) = ?', start_time.to_date).any?
      errors.add(:start_time, "Worker can't have two shifts on the same day")
    end
  end
end
