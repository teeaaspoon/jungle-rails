class UserMailer < ApplicationMailer
    default from: "no-reply@jungle.com"

    def order_receipt(user, order)
        @user = user
        @order_items = order.line_items
        mail(to: @user.email, subject: "Here is your order receipt for order #{order.id}!!")
    end
end
