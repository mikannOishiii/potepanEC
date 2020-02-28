module ApplicationHelper
  # 動的なタイトル
  def full_title(page_title = "")
    base_title = "POTEPAN BIGBAG Store"
    if page_title.blank?
      base_title
    else
      page_title + " - " + base_title
    end
  end
end
