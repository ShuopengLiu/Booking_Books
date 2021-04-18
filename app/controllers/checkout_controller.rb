class CheckoutController < ApplicationController
  def create
    # .find will bring back a collection of objects based on those PK id's
    books = Book.find(session[:shopping_cart].keys)

    if books.nil?
      redirect_to root_path
      return
    end

    line_items = []

    books.each do |book|
      line_items.push(
        {
          name:     book.title,
          amount:   100,
          currency: "cad",
          quantity: session[:shopping_cart][book.id.to_s]
        }
      )
    end

    logger.debug "Items: #{line_items}"
    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
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
