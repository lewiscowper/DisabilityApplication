class Submission < ActiveRecord::Base
  belongs_to :professor
  has_many :mail_records

  validates :student_name, presence: true
  validates :student_email, presence: true,
            :email_format => {:message => 'is not an email'}
  validates :course_number, presence: true
  validates :actual_test_length, numericality: true
  validates :student_test_length, numericality: true
  validates :exam_pickup, presence: true
  validates :exam_return, presence: true
  validates :reader, :inclusion => {:in => [true, false]}
  validates :scribe, :inclusion => {:in => [true, false]}
  validates :laptop, :inclusion => {:in => [true, false]}
  validates :professor, existence: true

  scope :find_in_date, -> (beginning, ending) { where(start_time: beginning..ending) }
  scope :today, -> { find_in_date(DateTime.now.beginning_of_day, DateTime.now.end_of_day) }
  scope :tomorrow, -> { find_in_date(DateTime.tomorrow.beginning_of_day, DateTime.tomorrow.end_of_day) }

  def start_time_formatted
    start_time ? start_time.to_formatted_s(:long_ordinal) : ""
  end

  def end_time
    start_time ? start_time + student_test_length.minutes : nil
  end
end
