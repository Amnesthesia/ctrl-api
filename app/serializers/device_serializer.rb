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

class DeviceSerializer < ActiveModel::Serializer
  attributes :id
end
