class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @order_id=OrderFriend.where(user_id:current_user.id)
    @orders = Order.where(user_id: current_user.id).or(Order.where(id:@order_id))
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @groupFriends = GroupFriend.where(group_id: params[:order_groups])
  end

  # GET /orders/new
  def new
    @order = Order.new
    @friends = Friendship.where(user_id: current_user.id)
    @groups = Group.where(user_id: current_user.id)
  end

  # GET /orders/1/edit
  def edit
    @friends = Friendship.where(user_id: current_user.id)
    @groups = Group.where(user_id: current_user.id)
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.build(order_params)
    @order.save
    @friends = User.where(id: params[:order_friends])
    @groupFriends = GroupFriend.where(group_id: params[:order_groups])
    add_group_friends(@groupFriends, @order)
    send_notifications(@friends, @order)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Send Notifications To User
    def send_notifications(friends, order)
      friends.each do |friend|
        NotificationChannel.broadcast_to(friend, sender: current_user.email, type: order.order_type)
        @order_friend = OrderFriend.new(:order_id => order.id, :user_id => friend.id)
        @order_friend.save
      end
    end
    def add_group_friends(groupFriends, order)
      groupFriends.each do |friend|
        @order_friend = OrderFriend.new(:order_id => order.id, :user_id => friend.user_id)
        @order_friend.save
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_type, :restaurant, :picture) 
    end
end
