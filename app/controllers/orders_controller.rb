class OrdersController < ApplicationController
  def index
    @product = Product.find(params[:product_id]) # 追加：商品情報を取得
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    binding.pry # フォームから送られたパラメータを確認

    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      @product = Product.find(params[:product_id]) # バリデーション失敗時も@productが必要なので追加
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building, :phone_number, :token
    ).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
