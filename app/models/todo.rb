# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :note, presence: true
  validates :time_start, presence: true
  validates :time_complete, presence: true
  validates_comparison_of :time_complete, greater_than: :time_start, other_than: Date.today
  validates :is_complete, inclusion: [true, false]
  scope :is_complete, -> { where(is_private: false) }
end
