module CartsHelper
  def total
    @cart = session[:cart]
    @sum = 0
    @cart.each do |key, val|
      @sum += val * Product.by_id(key)[0].price
    end
    @sum
  end
  def get_giftcode
    @giftcode_user = Giftcode.get_giftcode(@current_user.id)
    @giftcode = @giftcode_user[0].id || 1
    @giftcode
  end
end
