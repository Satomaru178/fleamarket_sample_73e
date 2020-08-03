class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :birthday, presence: true

  validates :nickname, uniqueness:true, presence: true

  validates :email, uniqueness: true

  validates :first_name, :last_name,
  format: {
    with: /\A[ぁ-んァ-ン一-龥]+\z/
  }

  validates :password,
  format: {
    with: /\A[a-zA-Z0-9]+\z/
  }

  validates :first_name_kana, :last_name_kana,
  format: {
    with: /\A[ぁ-んー－]+\z/
  }

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one  :address
  has_one  :account
  has_one  :creditcard

end
