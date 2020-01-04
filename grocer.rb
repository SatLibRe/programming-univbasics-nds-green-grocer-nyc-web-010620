require "pry"

# def find_item_by_name_in_collection(name, collection)
#   i = 0 
#   while i < collection.length do 
#     if collection[i][:item] == name
#       return collection[i] 
#     end 
#       i += 1
#   end
#   nil
# end

# def consolidate_cart(cart)
#   new_cart = []
#   counter = 0 
#   while counter < cart.length do 
#       new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
#       if new_cart_item
#         new_cart_item[:count] += 1 
#       else 
#         new_cart_item = {
#           :item => cart[counter][:item], 
#           :price => cart[counter][:price], 
#           :clearance => cart[counter][:clearance], 
#           :count => 1
#         }
#         new_cart << new_cart_item
#       end
#     counter += 1 
#   end 
# new_cart
# end

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item],cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name,cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
    else 
      cart_item_with_coupon = {
        :item => couponed_item_name, 
        :price => coupons[counter][:cost] / coupons[counter][:num],
        :count => coupons[counter][:num], 
        :clearance => cart_item[:clearance]
      }
      cart.push(cart_item_with_coupon)
      cart_item[:count] -= coupons[counter][:num]
    end   
  end
counter += 1
end
cart 
end

# def apply_clearance(cart)
#   counter = 0 
#   while counter < cart.length
#     if cart[counter][:clearance] 
#       cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
#     end 
#   counter += 1
#   end
# cart 
# end
  


# def checkout(cart, coupons)
#   consolidated_cart = consolidate_cart(cart)
#   couponed_cart = apply_coupons(consolidated_cart,coupons)
#   final_cart = apply_clearance(couponed_cart)
  
#   total = 0 
#   counter = 0 
#   while counter < final_cart.length do 
#     total += final_cart[counter][:price] * final_cart[counter][:count] 
#     counter += 1
#   end 
#   if total > 100 
#     total -= (total * 0.10) 
#   end 
#   total 
# end









def find_item_by_name_in_collection(item,aoh)
  aoh.each do |item_obj|
    if item == item_obj[:item]
      return item_obj
    end 
  end 
  nil 
end 

def consolidate_cart(aoh)
  new_arr = []
    aoh.each do |item_obj|
      if item_obj[:count]
        item_obj[:count] += 1
      else
        item_obj[:count] = 1 
        new_arr.push(item_obj)
      end 
    end
    new_arr
end 

# [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2},
# {:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2}]

# => [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]

# def apply_coupons(aoh,coupons)
#   new_arr = []
#     aoh.each do |item_obj|
#       coupons.each do |coupon_obj|
#         new_hash = {}
#         if item_obj[:item] == coupon_obj[:item] && item_obj[:count] >= coupon_obj[:num]  
#           new_hash[:item] = "#{item_obj[:item]} W/COUPON"
#           new_hash[:price] = coupon_obj[:cost] / coupon_obj[:num]
#           new_hash[:clearance] = item_obj[:clearance]
#           new_hash[:count] = coupon_obj[:num]
#           item_obj[:count] -= coupon_obj[:num] 
#             new_arr.push(new_hash)
#             new_arr.push(item_obj)
#           else 
#           new_arr.push(item_obj)
#       end
#     end 
#   end 
#   new_arr 
# end

def apply_clearance(aoh)
     aoh.each do |item_obj|
       if item_obj[:clearance] == true 
         item_obj[:price] = (item_obj[:price] - (item_obj[:price] * 0.20))
       end 
    end 
end 

def checkout(aoh,coupons)
  grand_total = 0 
  consolidated_cart = consolidate_cart(aoh)
  consolidated_cart_couponed_cart = apply_coupons(consolidated_cart,coupons)
  final_cart = apply_clearance(consolidated_cart_couponed_cart)
    final_cart.each do |cart_obj|
      grand_total += (cart_obj[:price] * cart_obj[:count])
    end 
    if grand_total > 100 
      grand_total -= (grand_total * 0.10)
    end 
    grand_total 
end 


