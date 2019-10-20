class StoresController < ApplicationController
  before_action :authorize_owner, only: :create
  before_action :authorize_admin, only: %i[update destroy]
  before_action :set_store, only: %i[show update destroy]

  # GET /stores
  def index
    @stores = Store.where(query_params).page(page).per(per_page)

    render json: serialize('Store', @stores)
  end

  # GET /stores/1
  def show
    render json: serialize('Store', @store)
  end

  # POST /stores
  def create
    @store = current_user.build_store(store_params)

    if @store.save
      render json: serialize('Store', @store), status: :created
    else
      render json: ame_serialize(@store.errors),
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      render json: @store
    else
      render json: ame_serialize(@store.errors), status: :unprocessable_entity
    end
  end

  # DELETE /stores/1
  def destroy
    @store.destroy
  end

  private

  def query_params
    queries.permit(:owner_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def store_params
    attributes.permit(:name)
  end
end
