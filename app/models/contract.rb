# == Schema Information
#
# Table name: contracts
#
#  id                    :bigint           not null, primary key
#  contract_name         :string
#  created_by            :integer
#  description           :text
#  monetary_compensation :integer
#  other_compensation    :string
#  tasks_count           :integer
#  token                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Contract < ApplicationRecord
  has_many  :tasks, class_name: "Task", foreign_key: "contract_id", dependent: :destroy
  has_many  :parties, class_name: "Party", foreign_key: "contract_id", dependent: :destroy
  belongs_to :deal_creator, required: true, class_name: "User", foreign_key: "created_by", counter_cache: :deals_count
end
