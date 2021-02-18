require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
 index = 0 
 while index < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
   coupon_item_name = "#{coupons[index][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
     if cart_item && cart_item[:count] >= coupons[index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[index][:num]
      else cart_item_with_coupon = { 
        :item => coupon_item_name , 
        :price => coupons[index][:cost] / coupons[index][:num] , 
        :count => coupons[index][:num] , 
        :clearance => cart_item[:clearance]
      }
      
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[index][:num]
    end
  end
  index +=1 
 end 
 cart
end

def apply_clearance(cart)
  index = 0 
   while index < cart.length
    if cart[index][:clearance]
     cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.20)).round(2)
    end 
   index += 1 
  end 
 cart 
end

def checkout(cart, coupons)
   con_cart = consolidate_cart(cart)
   cou_cart = apply_coupons(con_cart, coupons)
   fin_cart = apply_clearance(cou_cart)
  
   total = 0 
   index = 0 
   while index < fin_cart.length
   total += fin_cart[index][:price] * fin_cart[index][:count]
   index += 1 
  end
  if total > 100
    total -= (total * 0.10)
  end 
  total
end
