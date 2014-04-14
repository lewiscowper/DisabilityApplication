class Submission < ActiveRecord::Base
  belongs_to :professor
  has_many :mail_records

  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :course_number, presence: true
  validates :class_length, numericality: true
  validates :exam_pickup, presence: true
  validates :exam_return, presence: true
  validates :reader, :inclusion => {:in => [true, false]}
  validates :scribe, :inclusion => {:in => [true, false]}
  validates :laptop, :inclusion => {:in => [true, false]}
  validates :professor, existence: true

  scope :find_in_date, -> (beginning, ending) { where(start_time: beginning..ending) }
  scope :today, -> { find_in_date(DateTime.now.beginning_of_day, DateTime.now.end_of_day) }

  def start_time_formatted
    start_time ? start_time.to_formatted_s(:long_ordinal) : ""
  end

  # When extended is set, removed extended_amount is extended is false
  def extended=(val)
    super(val)
    self.extended_amount = nil unless val == 1
  end
end