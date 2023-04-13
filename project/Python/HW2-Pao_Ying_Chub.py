# Pao_Ying_Chub
import random
def pao_ying_chub():
    user_name = input("Insert your name: ")
    print("Instruction: type 'exit' to exit the program")
    user_score = 0
    com_score = 0
    select = ["hammer" , "scissor" , "paper"]
    while True:
        user_select = input("Please select one? hammer / scissor / paper")
        com_select = random.choice(select)
        if user_select == "exit":
            print("The Game is End")
            if user_score > com_score:
                print("Congratulation You Win!!")
            elif user_score < com_score:
                print("You lose in this game!!")
            else :
                print("They have no winner!!")
            break
        elif user_select == com_select:
            print("Tie!!")
        elif (user_select == "hammer" and com_select == "scissor") or (user_select == "scissor" and com_select == "paper") or (user_select == "paper" and com_select == "hammer"):
            print("You Win!!")
            user_score += 1
        elif (user_select == "hammer" and com_select == "paper") or (user_select == "scissor" and com_select == "hammer") or (user_select == "paper" and com_select == "scissor"):
            print("You Lose!!")
            com_score += 1
        else:
            print("Word have not fould")

        print(f"com_select: {com_select}")
        print(f"You score: {user_score}")
        print(f"Com score: {com_score}")

# Play game        
pao_ying_chub()
