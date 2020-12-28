class ExcuseSchedule < ApplicationRecord
  belongs_to :schedule
  belongs_to :excuse
end
