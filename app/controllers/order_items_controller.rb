class OrderItemsController < ApplicationController
  respond_to :json

  before_action :load_order_item, only: [:show, :destroy, :start_service, :stop_service]

  api :GET, '/orders/:order_id/items/:id', 'Shows order item with :id'
  param :includes, Array, required: false, in: %w(product)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    # @todo: add policy for order item
    # authorize @order
    if @order_item
      respond_with_params @order_item
    else
      record_not_found
    end
  end

  api :DELETE, '/orders/:order_id/items/:id', 'Deletes order item with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    # @todo: add policy for order item
    # authorize @order
    if @order_item
      @order_item.destroy
      render json: @order_item
    else
      record_not_found
    end
  end

  api :PUT, '/orders/:order_id/items/:id/start_service', 'Starts service for order item'
  param :id, :number, required: true

  def start_service
    # @todo: add policy for order item
    # authorize @order_item
    # TODO: Direct ManageIQ to pass along a start request
    render nothing: true, status: :ok
  end

  api :PUT, '/orders/:order_id/items/:id/stop_service', 'Stops service for order item'
  param :id, :number, required: true

  def stop_service
    # @todo: add policy for order item
    # authorize @order_item
    # TODO: Direct ManageIQ to pass along a stop request
    render nothing: true, status: :ok
  end

  private

  def orders_from_params
    OrderItem.where(id: params.require(:id), order_id: params.require(:order_id))
  end

  def load_order_item
    @order_item = orders_from_params.first
  end
end
