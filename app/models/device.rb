# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  uuid       :text
#  control_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Device < ActiveRecord::Base
  has_many :controls
end
