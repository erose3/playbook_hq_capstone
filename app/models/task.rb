class Task < ApplicationRecord
  belongs_to :deal, required: true, class_name: "Contract", foreign_key: "contract_id", counter_cache: true
  belongs_to :task_creator, required: true, class_name: "User", foreign_key: "created_by", counter_cache: true
end
