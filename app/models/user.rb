class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

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

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
      { user: user, sns: sns }
  end

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one  :address
  has_one  :account
  has_one  :creditcard
  has_many :sns_credentials

  # likes
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
end
