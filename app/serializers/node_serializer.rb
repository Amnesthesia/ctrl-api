# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  name       :string
#  x          :decimal(, )
#  y          :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :x, :y, :recent_control

  def recent_control
    object.recent_control
  end
end
