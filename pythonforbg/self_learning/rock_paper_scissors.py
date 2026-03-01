import random

def main():
    outcomes: list[str] = ["Rock", "Paper", "Scissor"]

    event = random.choice(outcomes)

    usr: str = input("What your choice? (r, p, s): ").strip().lower()
    # compare the win
    if compare(event, usr):
        print("YOU WON!")
    else:
        print("YOU LOOS!")
    print("Correct was:", event)


def compare(event: str, usr: str) -> bool:
    usr_event = ""
    if usr == "r":
        usr_event = "Rock"
    elif usr == "p":
        usr_event = "Paper"
    elif usr == "s":
        usr_event = "Scissor"
    else:
        print("Not a valid Choice!")

    if usr_event == event:
        return True
    else:
        return False

if __name__ == "__main__":
    main()
