class HomeController < ApplicationController
  def restricted
  end

  # THIS SHOULD BE IN LISTINGS CONTROLLER.rb
  post "/create-checkout-session" do
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      customer_email: current_user&.email,
      line_items: [{
        name: @listing.name,
        description: @listing.description,
        amount: @listing.price * 100,
        currency: "aud",
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user&.id,
          listing_id: @listing.id,
        },
      },
      success_url: "#{root_url}/success?title=#{@listing.title}",
      cancel_url: "#{root_url}/listings",
    })
    # Alex's example doesn't have outer purple } on lines 8 and 26
    @session_id = session.id
    redirect session.url, 303
  end
end

# IN PAYMENTS CONTROLLER:
# def success
#   @title = params[:title]
# end
