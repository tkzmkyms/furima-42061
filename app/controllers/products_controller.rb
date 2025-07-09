class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_product, only: [:show, :edit, :update]
  before_action :set_form_collections, only: [:new, :edit, :update]
  before_action :move_to_root_path, only: [:edit, :update]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def show
    # @product は set_product で取得済み
  end

  def edit
    # @product は set_product で取得済み
  end

  def update
    # @product は set_product で取得済み
    if @product.update(product_params)
      redirect_to @product, notice: '商品情報を更新しました'
    else
      set_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to root_path, notice: '出品が完了しました'
    else
      set_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_root_path
    redirect_to root_path unless current_user == @product.user
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :category_id, :status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
      :image
    )
  end

  def set_form_collections
    @categories = Category.all
    @statuses = Status.all
    @shipping_fee_statuses = ShippingFeeStatus.all
    @prefectures = Prefecture.all
    @scheduled_deliveries = ScheduledDelivery.all
  end
end
