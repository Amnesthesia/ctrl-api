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

class Node < ActiveRecord::Base
  has_many :controls

  acts_as_mappable	:default_units => :kms,
                    :default_formula => :sphere,
                    :lng_column_name => :y,
                    :lat_column_name => :x,
                    :distance_field_name => :distance


  def recent_control
    now = DateTime.now
    if self.controls.where(is_active: true, created_at: now..now - 2.hours)
      recent_controls = self.controls.where(is_active: true, created_at: now..now - 2.hours)
      recent_clear_marks = self.controls.where(is_active: false, created_at: now..now - 30.minutes)
      recent_control_marks = self.controls.where(is_active: true, created_at: now..now - 30.minutes)

      override = false

      if recent_clear_marks > recent_control_marks then
        if self.controls.order(:created_at).take(5).all is_active: true then
          override = true
        end
      end

      first_notified = self.controls.where(is_active: ((recent_clear_marks.count > recent_control_marks.count) or override), created_at: DateTime.now-3.hours).order(asc: :created_at).first



      {
        recent_control: (recent_controls.count > 1),
        recent_clear_marks: recent_clear_marks.count,
        recent_control_marks: recent_control_marks.count,
        verified: (recent_control_marks > 30 or recent_clear_marks > 30),
        first_notified: first_notified.created_at
      }
    else
      {
          recent_control: false,
          recent_clear_marks: 0,
          recent_control_marks: 0,
          verified: false,
          first_notified: first_notified.created_at
      }
    end
  end

end
