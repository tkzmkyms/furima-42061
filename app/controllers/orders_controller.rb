class OrdersController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @product = Product.find(params[:product_id])
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

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building, :phone_number, :token
    ).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
