## HW 01: Pao Ying Chub

play_game <- function() {
  options <- c("hammer", "scissor", "paper")
  print("Instruction: type 'exit' to exit the program")
  message(paste("This is Pao Ying Chub Game >> Please select:", paste(options, collapse = ", ")))
  user_score <- 0
  computer_score <- 0
  
  while (TRUE) {
    cat("Choose one:")
    user_s <- readLines("stdin",1)
    com_s <- sample(options, 1)
    
    if (user_s == "exit"){ 
      if (user_score > computer_score){
        print("Congratulation!!! You Win this game")
      } else if (user_score < computer_score){
        print("Sorry!!! You loss")
      } else {
        print("There are no winners in this game")
      }
      print("Thanks for playing")
      break
    } else if (user_s == com_s) {
      print(paste("Computer select: ", com_s))
      print("Tie!") 
    } else if ((user_s == "hammer" & com_s == "scissor") | 
               (user_s == "scissor" & com_s == "paper") | 
               (user_s == "paper" & com_s == "hammer")) {
      print(paste("Computer select: ", com_s))
      print("You Win!")
      user_score <- user_score + 1
    } else if ((com_s == "hammer" & user_s == "scissor") | 
               (com_s == "scissor" & user_s == "paper") | 
               (com_s == "paper" & user_s == "hammer")) {
      print(paste("Computer select:", com_s))
      print("You Lose!")
      computer_score <- computer_score + 1
    }
    print(paste("You score: ",user_score))
    print(paste("Computer score:",computer_score))
  }
}

play_game()
