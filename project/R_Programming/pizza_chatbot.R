pizza_chatbot <- function(){
  # Define initial variables
  customer_name <- ""
  customer_telephone <- ""
  num_pizzas <- 0
  pizzas_df <- data.frame()
  
  # Define pizza prices
  size_prices <- c(small = 10, medium = 15, large = 20)
  
  # Define functions for each step of the ordering process
  
  # Prompt for customer name
  cat("What is your name?")
  customer_name <- readline(prompt = "You:")
  
  # Prompt for customer telephone number
  cat("What is your telephone number?")
  customer_telephone <- readline(prompt = "You:")
  
  # Prompt for pizza size
  cat("What size pizza would you like? (small, medium, large)")
  size <- readline(prompt = "You:")
  while (size != "small" && size != "medium" && size != "large") {
    cat("Sorry, that's not a valid size.")
    size <- readline(prompt = "You:")
  }
  
  # Get the price for the selected size
  price <- size_prices[[size]]
  
  # Prompt for pizza toppings
  cat("What toppings would you like? (pepperoni, sausage, mushrooms, etc.)")
  toppings <- readline(prompt = "You:")
  
  # Prompt for pizza quantity
  cat("How many pizzas would you like to order?")
  quantity <- as.numeric(readline(prompt = "You:"))
  while (!is.numeric(quantity) || quantity <= 0) {
    cat("Sorry, that's not a valid quantity.")
    quantity <- as.numeric(readline(prompt = "You:"))
  }
  
  # Calculate the total price for the order
  total_price <- price * quantity
  
  # Prompt for pizza delivery option
  cat("Would you like your pizza delivered? (yes, no)")
  delivery_option <- readline(prompt = "You:")
  while (delivery_option != "yes" && delivery_option != "no") {
    cat("Sorry, that's not a valid option.")
    delivery_option <- readline(prompt = "You:")
  }
  
  # Add a pizza to the order
  add_pizza_to_order <- function() {
    if (delivery_option == "yes") {
      cat("What is your delivery address?")
      address <- readline(prompt = "You:")
    } else {
      address <- "N/A"
    }
    pizza <- data.frame(
      size = size,
      toppings = toppings,
      quantity = quantity,
      price = price,
      total_price = total_price,
      delivery_option = delivery_option,
      address = address
    )
  }
  
  # Place the order
  place_order <- function() {
    num_pizzas <- quantity
    pizzas_df <- rbind(pizzas_df, add_pizza_to_order())
    
    cat("Thank you for your order, ", customer_name, "!")
    cat("\n\nORDER SUMMARY\n")
    cat("Customer name: ", customer_name, "\n")
    cat("Telephone number: ", customer_telephone, "\n")
    cat("Number of pizzas: ", num_pizzas, "\n")
    cat("Total price: $", total_price, "\n")
    cat("\n")
    cat("PIZZA DETAILS\n")
    print(pizzas_df)
  }
  
  place_order()
}

pizza_chatbot()
