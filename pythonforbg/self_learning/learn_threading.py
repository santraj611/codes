"""Threading adds new new lanes for your program to execute"""
from threading import Thread
import time
import random

def print_names() -> None:
    for name in ("A", "B", "C", "D", "E"):
        print(name)
        time.sleep(random.uniform(0.5, 1.5))

def print_ages() -> None:
    for _ in range(5):
        print(random.randint(20, 50))
        time.sleep(random.uniform(0.5, 1.5))

t1 = Thread(target=print_names)
t2 = Thread(target=print_ages)

t1.start()
t2.start()

# at this point you can do other things

# since we don't have anything else to do.
# we will wait for the threads to finish.
# this will block the main thread
t1.join()
t2.join()
