# トップページ
crumb :root do
  link "FURIMA", root_path
end

# 商品出品ページ
crumb :product_new do
  link "商品出品", new_product_path
end

# 詳細検索ページ
crumb :detailed_search do
  link "詳細検索", products_path
end

# ブランド登録ページ
crumb :brand_new do
  link "ブランド登録", new_brand_path
end

# マイページ
crumb :mypage do
  link "マイページ", accounts_path
end

# マイページ、プロフィール
crumb :profile do
  link "プロフィール", edit_account_path(current_user.id)
  parent :mypage
end

# マイページ、クレジットカード
crumb :creditcard do
  link "支払い方法", creditcards_path
  parent :mypage
end

# マイページ、クレジットカード登録
crumb :creditcard_new do
  link "クレジットカード登録", new_creditcard_path
  parent :creditcard
end

# マイページ、ログアウト確認画面
crumb :logout do
  link "ログアウト", logout_accounts_path
  parent :mypage
end

# マイページ、いいね一覧
crumb :like_index do
  link "いいね！一覧", likes_accounts_path
  parent :mypage
end

# マイページ、発送元・お届け先住所変更
crumb :edit_address do
  link "発送元・お届け先住所変更", edit_address_path(current_user.id)
  parent :mypage
end

# カテゴリー一覧
crumb :category_index do
  link "カテゴリー一覧", categories_path
end

# 親カテゴリー
crumb :parent_category do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}", category_path(category)
  parent :category_index
end

# 子カテゴリー
crumb :child_category do |category|
  category = Category.find(params[:id])
  # 表示しているページが子カテゴリーの一覧ページの場合
  if category.has_children?
    link "#{category.name}", category_path(category)
    parent :parent_category

  # 表示しているページが孫カテゴリーの一覧ページの場合
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :parent_category
  end
end

# 孫カテゴリー
crumb :grandchild_category do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :child_category
end

# 商品詳細ページ親カテゴリー
crumb :product_show_category do |product|
  product = Product.find(params[:id])
  link "#{product.category.root.name}", category_path(product.category.root)
  parent :category_index
end

# 商品詳細ページ子カテゴリー
crumb :product_show_category_child do |product|
  product = Product.find(params[:id])
  link "#{product.category.parent.name}", category_path(product.category.parent)
  parent :product_show_category
end

# 商品詳細ページ孫カテゴリー
crumb :product_show_category_grandchild do |product|
  product = Product.find(params[:id])
  link "#{product.category.name}", category_path(product.category)
  parent :product_show_category_child
end

# 商品詳細ページ、商品名
crumb :product_show do |product|
  product = Product.find(params[:id])
  link "#{product.name}", product_path(product)
  parent :product_show_category_grandchild
end

# 商品詳細ページ、商品編集
crumb :product_edit do |product|
  product = Product.find(params[:id])
  link "商品編集", edit_product_path(product)
  parent :product_show
end

# 商品詳細ページ、購入確認ページ
crumb :product_purchase do |product|
  product = Product.find(params[:id])
  link "購入確認", purchase_product_path(product)
  parent :product_show
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
