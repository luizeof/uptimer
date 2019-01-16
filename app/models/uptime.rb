# == Schema Information
#
# Table name: uptimes
#
#  id         :integer          not null, primary key
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Uptime < ApplicationRecord

  scope :recent, -> { where("created_at >= ?", 7.days.ago) }

end
