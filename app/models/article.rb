class Article < ApplicationRecord
  enum published_status: { open: true, close: false }
  enum category: { recruit: 0, entry: 1 }
  enum day_of_the_week: { saturday: 0, sunday: 1, both: 2, other: 3, any: 4 }, _prefix: true
  enum band_intention: { professional: 0, indies: 1, hobby: 2, any: 3 }, _prefix: true
  enum music_intention: { original:0, copy: 1, any: 2 }, _prefix: true
  enum gender: { male: 0, female: 1, any: 2 }, _prefix: true
  enum band_theme: { beginner: 0, middle: 1, senior: 2, worker: 3, any: 4 }, _prefix: true
  enum status: { enable: true, disable: false }

  belongs_to :member
  belongs_to :prefecture
  has_many :article_favorites, dependent: :destroy
  has_many :genre_articles, dependent: :destroy
  has_many :genres, through: :genre_articles
  has_many :part_articles, dependent: :destroy
  has_many :parts, through: :part_articles
  has_many :article_cities, dependent: :destroy
  has_many :cities, through: :article_cities
  has_many :notices, dependent: :destroy

  # バリデーションSTART-------------------------------------------------------------------------------------------
  validates :published_status, presence: true
  validates :category, presence: true
  validates :day_of_the_week, presence: true
  validates :band_intention, presence: true
  validates :music_intention, presence: true
  validates :gender, presence: true
  validates :band_theme, presence: true
  validates :sound, format: { with: /\A#{URI::regexp(%w(http https))}\z/, allow_blank: true }
  validates :body, presence: true, length: { maximum: 5000 }
  validates :subject, presence: true, length: { maximum: 100 }
  validates :part_article_ids, presence: true
  validates :genre_article_ids, presence: true
  validates :age_min, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_blank: true}
  validates :age_max, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_blank: true}

  # age_maxとage_minに正しい大小関係で年齢が保存されるようにバリデーション
  class CheckAgeValidator < ActiveModel::Validator
    def validate(record)
      if record.age_max.present? && record.age_min.present?
        if record.age_max < record.age_min
          record.errors[:age_max] << "は#{Article.human_attribute_name(:age_min)}より大きい値を入力してください"
          record.errors[:age_min] << "は#{Article.human_attribute_name(:age_max)}より小さい値を入力してください"
        end
      end
    end
  end
  # 上記のカスタムバリデーション呼び出し
  validates_with CheckAgeValidator
# バリデーションEND---------------------------------------------------------------------------------------------

  # Gem kamirariの表示ページ数
  paginates_per 10

  # お気に入りしていればtrueを返す
  def favorited_by?(member)
    article_favorites.where(member_id: member.id).any?
  end

  # 最新順に並び替え（最終更新日）
  default_scope -> { order(updated_at: :desc)}


  #記事検索START----------------------------------------------------------------------------------------------
  def self.search(search_params)
    return all if search_params.blank?

    status_is(search_params[:status])
    .published_status_is(search_params[:published_status])
    .subject_like(search_params[:subject])
    .body_like(search_params[:body])
    .category_is(search_params[:category])
    .day_of_the_week_is(search_params[:day_of_the_week])
    .band_intention_is(search_params[:band_intention])
    .music_intention_is(search_params[:music_intention])
    .band_theme_is(search_params[:band_theme])
    .gender_is(search_params[:gender])
    .age_min(search_params[:age_min])
    .age_max(search_params[:age_max])
    .prefecture_is(search_params[:prefecture_id])
    .city_is(search_params[:city_ids])
    .part_is(search_params[:part_ids])
    .genre_is(search_params[:genre_ids])
  end

  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :published_status_is, -> (published_status) { where(published_status: published_status) if published_status.present? }
  scope :subject_like, -> (subject) { where('subject LIKE ?', "%#{subject}%") if subject.present? }
  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
  scope :category_is, -> (category) { where(category: category) if category.present? }
  scope :day_of_the_week_is, -> (day_of_the_week) { where(day_of_the_week: day_of_the_week) if day_of_the_week.present? && day_of_the_week != "any" }
  scope :band_intention_is, -> (band_intention) { where(band_intention: band_intention) if band_intention.present? && band_intention != "any" }
  scope :music_intention_is, -> (music_intention) { where(music_intention: music_intention) if music_intention.present? && music_intention != "any" }
  scope :band_theme_is, -> (band_theme) { where(band_theme: band_theme) if band_theme.present? && band_theme != "any" }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? && gender != "any" }
  scope :age_min, -> (min) { where('? <= age_min', min) if min.present? }
  scope :age_max, -> (max) { where('age_max <= ?', max) if max.present? }
  scope :prefecture_is, -> (prefecture) { where(prefecture_id: prefecture.to_i) if prefecture.present? }

  scope :city_is, -> (city) do
    unless city[1].nil?
      article_ids = ArticleCity.where(city_id: city).map{|k| k.article_id}
      where(id: article_ids)
    end
  end

  scope :part_is, -> (part) do
    unless part[1].nil?
      article_ids = PartArticle.where(part_id: part).map{|k| k.article_id}
      where(id: article_ids)
    end
  end

  scope :genre_is, -> (genre) do
    unless genre[1].nil?
      article_ids = GenreArticle.where(genre_id: genre).map{|k| k.article_id}
      where(id: article_ids)
    end
  end
end
