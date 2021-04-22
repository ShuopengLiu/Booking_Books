class CheckoutController < ApplicationController
  def create
    # .find will bring back a collection of objects based on those PK id's
    books = Book.find(session[:shopping_cart].keys)

    if books.nil?
      redirect_to root_path
      return
    end

    # Create order : status, total_price, address,   (user_id, province_id)
    order = Order.create(
      status:      "new",
      total_price: subtotal,
      address:     current_user.address,
      user:        User.find(current_user.id),
      province:    User.find(current_user.id).province
    )

    if order.save
      logger.debug("LSP****Order Create Successfull: #{order}")
    else
      logger.debug("LSP****Order Create Failure: #{order}")
    end

    line_items = []

    books.each do |book|
      # Create ordered_book: quantity, selling_price  (book_id, order_id)
      ordered_book = OrderedBook.create(
        quantity:      session[:shopping_cart][book.id.to_s].to_i,
        selling_price: book.price,
        book:          Book.find(book.id),
        order:         Order.find(order.id)
      )

      if ordered_book.save
        logger.debug("LSP****Ordered Book Create Success: #{ordered_book}")
      else
        logger.debug("LSP****Ordered Book Create Failure: bookid#{book.id} orderid#{order.id} price#{book.price}")
      end
      # Create line_items for stripe checkout object
      line_items.push(
        {
          name:     book.title,
          amount:   book.price,
          currency: "cad",
          quantity: session[:shopping_cart][book.id.to_s]
        }
      )
    end

    line_items.push(
      {
        name:     "Tax",
        amount:   (subtotal * current_user.province.total_tax_rate).to_i,
        currency: "cad",
        quantity: 1
      }
    )

    logger.debug "Items: #{line_items}"
    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           line_items
    )

    logger.debug "***Session***: #{@session.id}"

    # ensure it formats the response as .js instead of .html:
    respond_to do |format|
      format.html # render app/views/checkout/create.html.erb
    end
  end

  def success
    # We took the customer's money!
    # checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
    # when strope redirects back to server... it will append this id through a GET params!
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # Something went wrong with the payment :(
  end
end
