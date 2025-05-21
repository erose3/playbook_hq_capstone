class Party < ApplicationRecord
  belongs_to :contract, required: true, class_name: "Contract", foreign_key: "contract_id"
  belongs_to :athlete, required: true, class_name: "User", foreign_key: "party_id", counter_cache: :endorsement_assignments_count
end
