class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :update_price, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :sell_in, :price)
    end

    def update_price
      Product.all.each do |product|
        days_count_created = (Date.parse(product.created_at.to_s) - DateTime.now).to_i        
        product.update(sell_in: product.sell_in - 1)
        # Full Coverage
        # Actually increases in price the older it gets
        if (product.name == 'Full Coverage') && (product.price <= 50)
          p 'Full Coverage'
          product.update(price: product.price + 1)
          product.update(sell_in: product.sell_in - 1)
            if (product.sell_in < 0) && (product.price > 0)
        end
        # Mega Coverage
        # being a legendary product, never has to be sold or decreases in price.
        if (product.name == 'Mega Coverage')          
          product.update(sell_in: product.sell_in - 1)
        end
        # Special Full Coverage
        # Like full coverage, increases in price as its sellIn value approaches:
        # price increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but.
        # price drops to 0 when no more days left (and the product is not valid anymore).
        if (product.name == 'Special Full Coverage') && (product.price <= 50)
          product.update(price: product.price + 2) if product.sell_in < 10
          product.update(price: product.price + 3) if product.sell_in < 5
          product.update(price: 0) if product.sell_in.zero?
        end
        # Super Sale
        # Products degrade in price twice as fast as normal Products.
        if (product.name == 'Super Sale') && (product.price <= 50)
          product.update(price: product.price - 2)
        end
      end
    end
  end
end
