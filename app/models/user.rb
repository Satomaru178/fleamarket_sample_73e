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
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end

  has_many :products, dependent: :destroy
  has_one  :address
  has_one  :account
  has_one  :creditcard
  has_many :sns_credentials
end
