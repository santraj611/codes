import threading
import time

### In this file we are managing multithreading
### suppose, multiple threads are trying to access same resource
### how do we manage that? and insure we are not getting any errors?

x = 8192
lock = threading.Lock()

def double():
    global x, lock
    # acquire the lock first to do anything
    # if we can't acquire lock meaning it is already in use by someone else
    # if it's locked then we wait, until we get the lock
    lock.acquire() 
    while x < 16384:
        x *= 2
        print(x)
    print("Reached Maximum!")

    # after using the resource we are going to release the lock
    lock.release()

def halve():
    global x, lock
    lock.acquire()
    while x > 1:
        x /= 2
        print(x)
    print("Reached Minimum!")
    lock.release()

t1 = threading.Thread(target=halve)
t2 = threading.Thread(target=double)

t1.start()
t2.start()

t1.join()
t2.join()

################################################################

# but what if we just want limit the no. of accesses
# we can do that with semaphore
semaphore = threading.BoundedSemaphore(value=5) # value is maxm access

def access(thread_no: int):
    global semaphore
    print("{} is trying to access!".format(thread_no))
    semaphore.acquire()
    print("{} was granted access!".format(thread_no))
    time.sleep(10)
    print("{} is now releasing!".format(thread_no))
    semaphore.release()

for i in range(1, 11):
    t = threading.Thread(target=access, args=(i,))
    t.start()
    time.sleep(1)
