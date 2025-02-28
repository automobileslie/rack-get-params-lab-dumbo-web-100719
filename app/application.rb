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

    elsif req.path.match(/cart/)
      if @@cart != []
      @@cart.each do |item_in_cart|
        resp.write "#{item_in_cart}\n"
      end

      else resp.write "Your cart is empty."
      end

    elsif req.path.match(/add/)
      search_term = req.params["item"]
      if @@items.include?(search_term)
        resp.write "We added #{search_term} to your cart."
        @@cart.push("#{search_term}")
      else 
        resp.write "We don't have that item."
      end 

    else  
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
