from threading import Thread
from urllib.request import urlopen
import time

def do_some_cpu_work() -> None:
    for i in range(20_000):
        _ = 2 ** i

def do_some_io_work() -> None:
    urlopen("https://archlinux.org/")

if __name__ == "__main__":
    threads = []
    start = time.perf_counter()

    # using threads
    for _ in range(10):
        t = Thread(target=do_some_io_work)
        # t = Thread(target=do_some_cpu_work)
        threads.append(t)
        t.start()

    # can not skip this b/c. we need to wait until the thread is completed
    for t in threads:
        t.join()

    # without threads
    # for _ in range(10):
        # do_some_cpu_work()
        # do_some_io_work()
    print(f"time: {time.perf_counter() - start:.4f}s")
