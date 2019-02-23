require 'pry'

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      resp.write "#{search_term} is one of our items"
    else
      resp.write "Couldn't find #{search_term}"
    end
  end
  
  # def handle_cart(cart_item)
  #     binding.pry
  #   if @@cart.include?(cart_item)
  #     @@cart.each do |el|
  #       resp.write "#{el}\n"
  #     end
  #   else
  #     resp.write "Your cart is empty."
  #   end
  # end
end
