require 'kramdown'

class Activity < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments

  scope :visible, -> { where(visible: true) }

  def remaining_seats
    seats_taken = enrollments.where(committed: true).count
    max_seats - seats_taken
  end

  def description_as_html
    Kramdown::Document.new(description).to_html.html_safe
  end
end
