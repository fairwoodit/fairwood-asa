require 'redcarpet'

class Activity < ActiveRecord::Base
  belongs_to :season
  has_many :enrollments
  has_many :students, through: :enrollments

  scope :visible, -> { where(visible: true) }

  before_save :update_html_description

  def remaining_seats
    seats_taken = enrollments.where(committed: true).count
    max_seats - seats_taken
  end

  def update_html_description
    self.html_description =
        Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(description)
  end
end
