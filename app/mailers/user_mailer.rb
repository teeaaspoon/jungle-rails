class UserMailer < ApplicationMailer
    default from: "no-reply@jungle.com"

    def order_receipt(order)
        @order = order
        @order_items = order.line_items
        mail(to: @order.email, subject: "Here is your order receipt for order #{order.id}!!")
    end
end
