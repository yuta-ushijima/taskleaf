class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}


  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  # ransackable_attributesをオーバーライドして、検索対象のparamsを指定
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  # ransackable_associationsをオーバーライドして、検索条件に意図しない関連を含めないようにする
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
