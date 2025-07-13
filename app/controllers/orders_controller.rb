class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :redirect_if_invalid_access

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY')

      begin
        Payjp::Charge.create(
          amount: @product.price,
          card: order_params[:token],
          currency: 'jpy'
        )
      rescue Payjp::PayjpError => e
        flash[:alert] = "決済処理に失敗しました。#{e.message}"
        render :index and return
      end

      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def redirect_if_invalid_access
    # 出品者自身、または売却済み商品の場合はトップページへリダイレクト
    return unless @product.user_id == current_user.id || @product.order.present?

    redirect_to root_path
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building, :phone_number, :token
    ).merge(user_id: current_user.id, product_id: @product.id)
  end
end
