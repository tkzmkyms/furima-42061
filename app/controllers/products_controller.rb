class ProductsController < ApplicationController
  # ログインしていないユーザーはnewアクションにアクセスできないようにする
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    # 新規商品の空インスタンスを作成（フォーム用）
    @product = Product.new
  end

  def create
    # フォームから送信されたデータでProductの新規レコードを作成
    @product = Product.new(product_params)
    @product.user = current_user # 出品者をログインユーザーに設定

    if @product.save
      redirect_to root_path, notice: '出品が完了しました'
    else
      # バリデーションエラーの場合は再度出品ページを表示
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :category_id, :status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
      :image
    )
  end
end
