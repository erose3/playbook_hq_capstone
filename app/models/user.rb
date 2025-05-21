class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :deals, class_name: "Contract", foreign_key: "created_by", dependent: :destroy
  has_many  :tasks, class_name: "Task", foreign_key: "created_by", dependent: :destroy
  has_many  :endorsement_assignments, class_name: "Party", foreign_key: "party_id", dependent: :nullify 

end
