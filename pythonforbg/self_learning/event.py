import threading
import sys

event = threading.Event()

def verify_user():
    print("Waiting for you to verify yourself...")
    event.wait()
    print("You are now verified!")

t = threading.Thread(target=verify_user)
t.start()

x = input("Do you want to verify yourself? (y/n)")
if x == "y":
    event.set()
