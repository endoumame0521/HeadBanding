class Article < ApplicationRecord
  enum published_status: { open: true, close: false }
  enum category: { recruit: 0, entry: 1 }
  enum day_of_the_week: { saturday: 0, sunday: 1, both: 2, other: 3 }
  enum band_intention: { professional: 0, indies: 1, hobby: 2 }
  enum music_intention: { original:0, copy: 1 }
  enum gender: { male: 0, female: 1 }
  enum band_theme: { beginner: 0, middle: 1, senior: 2, worker: 3 }
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
  has_many :notices

  def favorited_by?(member)
    article_favorites.where(member_id: member.id).any?
  end

  #会員検索----------------------------------------------------------------------------------
  def self.search(search_params)
    return where(status: "enable") if search_params.blank?

      where(status: "enable")
      subject_like(search_params[:subject])
      .body_like(search_params[:body])
      .category_is(search_params[:category])
      .day_of_the_week_is(search_params[:day_of_the_week])
      .band_intention_is(search_params[:band_intention])
      .music_intention_is(search_params[:music_intention])
      .band_theme_is(search_params[:band_theme])
      .gender_is(search_params[:gender])
      .age_min(search_params[:age_min])
      .age_max(search_params[:age_max])
      .prefecture_is(search_params[:prefecture_ids])
      .city_is(search_params[:city_ids])
      .part_is(search_params[:part_ids])
      .genre_is(search_params[:genre_ids])
  end

  scope :subject_like, -> (subject) { where('subject LIKE ?', "%#{subject}%") if subject.present? }
  scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }
  scope :category_is, -> (category) { where(category: category) if category.present? }
  scope :day_of_the_week_is, -> (day_of_the_week) { where(day_of_the_week: day_of_the_week) if day_of_the_week.present? }
  scope :band_intention_is, -> (band_intention) { where(band_intention: band_intention) if band_intention.present? }
  scope :music_intention_is, -> (music_intention) { where(music_intention: music_intention) if music_intention.present? }
  scope :band_theme_is, -> (band_theme) { where(band_theme: band_theme) if band_theme.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :age_min, -> (min) { where('? <= age', min) if min.present? }
  scope :age_max, -> (max) { where('age <= ?', max) if max.present? }

  scope :prefecture_is, -> (prefecture) do
    where(prefecture_id: prefecture) unless prefecture[1].nil?
  end

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
