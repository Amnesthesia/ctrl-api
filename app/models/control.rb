# == Schema Information
#
# Table name: controls
#
#  id         :integer          not null, primary key
#  name       :string
#  node_id    :integer
#  device_id  :integer
#  is_active  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Control < ActiveRecord::Base
  belongs_to :node
  belongs_to :device
end
