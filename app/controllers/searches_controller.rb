class SearchesController < ApplicationController
  # 都道府県のセレクトボックスが選択されたら市区町村の表示がソートされて切り替わる。
  # 市区町村のチェックボックスはパーシャル化している。
  def cities_select
    if request.xhr?
      render partial: "layouts/cities_select", locals: { prefecture_id: params[:prefecture_id] }
    end
  end

  def cities_select_regist
    if request.xhr?
      prefecture_id = Prefecture.find_by(name: params[:prefecture_name])
      render partial: "members/registrations/cities_select", locals: { prefecture_id: prefecture_id }
    end
  end
end
