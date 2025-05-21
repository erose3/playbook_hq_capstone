# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  account_type                  :string
#  avatar_url                    :string
#  deals_count                   :integer
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  endorsement_assignments_count :integer
#  first_name                    :string
#  last_name                     :string
#  organization                  :string
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  tasks_count                   :integer
#  username                      :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :deals, class_name: "Contract", foreign_key: "created_by", dependent: :destroy
  has_many  :tasks, class_name: "Task", foreign_key: "created_by", dependent: :destroy
  has_many  :endorsement_assignments, class_name: "Party", foreign_key: "party_id", dependent: :nullify 

   # ensure it starts with @ and only letters, numbers, underscores
   validates :username,
             presence:   true,
             uniqueness: { case_sensitive: false },
             format:     {
               with:    /\A@[A-Za-z0-9_]+\z/,
               message: "must start with @ and only include letters, numbers, and underscores"
             }

   before_validation :prefix_username_with_at

   private

   def prefix_username_with_at
     return if username.blank? || username.start_with?("@")
     self.username = "@#{username}"
   end

end
