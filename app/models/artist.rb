class Artist < ApplicationRecord
  belongs_to :member

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :name, length: { maximum: 100 }, allow_nil: true

  # 空は許可、空白は禁止をするカスタムバリデーションです
  class CheckBlankExceptEmptyValidator < ActiveModel::Validator
    def validate(record)
      unless record.name.empty?
        if record.name.blank?
          record.errors[:name] << "には文字を入力するか何も入力しないでください。"
        end
      end
    end
  end
  # 上記のカスタムバリデーション呼び出し
  validates_with CheckBlankExceptEmptyValidator
  # バリデーションEND--------------------------------------------------------------------------------------------
end