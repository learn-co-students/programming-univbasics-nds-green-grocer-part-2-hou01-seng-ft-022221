require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_hash = {}
  
  if coupons == []
    return cart
  end
  
  cart.each_with_index do |(cart_key, cart_value), cart_index|
    coupons.each_with_index do |(coupon_key, coupon_value), coupon_index|
      if cart_key[:item] == coupon_key[:item]
        if cart_key[:count] >= coupon_key[:num]
          cart_key[:count] -= coupon_key[:num]
          cart << coupon_hash.merge({item: "#{coupon_key[:item]} W/COUPON", price: (coupon_key[:cost] / coupon_key[:num]), clearance: cart_key[:clearance], count: coupon_key[:num]})
        end
      end
    end
  end
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each_with_index do |(cart_key, cart_value), cart_index|
    if cart_key[:clearance] == true
      cart_key[:price] -= cart_key[:price] * 0.20
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
  
  new_cart.each_with_index do |(cart_key, cart_value), cart_index|
    total += cart_key[:count] * cart_key[:price]
  end
  
  if total > 100
    return total -= total * 0.10
  end
  return total
end
