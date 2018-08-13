class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
end
