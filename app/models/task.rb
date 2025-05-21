# == Schema Information
#
# Table name: tasks
#
#  id                :bigint           not null, primary key
#  assigned_to       :integer
#  completed_on      :date
#  completion_status :boolean
#  created_by        :integer
#  deadline          :date
#  description       :text
#  task_name         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  contract_id       :integer
#
class Task < ApplicationRecord
  belongs_to :deal, required: true, class_name: "Contract", foreign_key: "contract_id", counter_cache: true
  belongs_to :task_creator, required: true, class_name: "User", foreign_key: "created_by", counter_cache: true
end
