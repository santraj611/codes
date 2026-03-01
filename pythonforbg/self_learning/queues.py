import queue


def main() -> None:
    # queues are of 2 type
    # first in first out queue and
    # last in first out queue

    ### first in first out queue
    q = queue.Queue()
    numbers = [10, 20, 30, 40, 50, 60, 70, 80, 90]
    for num in numbers:
        q.put(num)
    print(q.get())
    print(q.get())
    print(q.get())

    ### last in first out queue
    s = queue.LifoQueue()
    for num in numbers:
        s.put(num)
    print(s.get())
    print(s.get())
    print(s.get())

    ### there is also a priority queue
    # this allows us to give priority to every number via a tuple
    # lower the number higher the priority
    p = queue.PriorityQueue()
    p.put((2, "Hello, world")) # Priority: 2, Item: "Hello, world"
    p.put((11, 99)) # Priority: 11, Item: 99
    p.put((5, 7.5)) # Priority: 5, Item: 7.5
    p.put((1, True)) # Priority: 1, Item: True

    while not p.empty():
        print(p.get()) # returns the highest priority item


if __name__ == "__main__":
    main()
