class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :birthday, presence: true
  validates :nickname, :email, uniqueness: true, presence: true
  validates :first_name, :last_name, presence: true,
                 format: {
                   with:/\A[ぁ-んァ-ン一-龥]/,
                 }
  validates :first_name_kana, :last_name_kana, presence: true,
  format: {
  with:/\A[ぁ-んー－]+\z/,
  }
  has_one :address
end