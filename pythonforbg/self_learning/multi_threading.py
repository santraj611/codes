import threading

def count_to_ten_million():
    i: int = 0
    while i < 10_000_000:
        i += 1
    print("i: %d" % i)

def count_to_million():
    i: int = 0
    while i < 1_000_000:
        i += 1
    print("i: %d" % i)

def main():
    # for x in range(0, 10):
    #     if x % 2 == 1:
    #         t = threading.Thread(target=count_to_ten_million)
    #         t.start()
    #         continue
    #     else:
    #         t = threading.Thread(target=count_to_million)
    #         t.start()
    
    t = threading.Thread(target=count_to_ten_million)
    t.start()

    # if you wnat the `t` to finish before executing next line, you can wait
    t.join()
    print("I am done!")

if __name__ == "__main__":
    main()
