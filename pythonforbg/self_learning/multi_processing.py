from multiprocessing import Process
from urllib.request import urlopen
import time

def do_some_cpu_work() -> None:
    for i in range(20_000):
        _ = 2 ** i

def do_some_io_work() -> None:
    urlopen("https://archlinux.org/")


def main() -> None:
    processes: list[Process] = []
    start = time.perf_counter()

    # using threads
    for _ in range(10):
        # p = Process(target=do_some_io_work)
        p = Process(target=do_some_cpu_work)
        processes.append(p)
        p.start()

    # can not skip this b/c. we need to wait until the thread is completed
    for p in processes:
        p.join()

    # without threads
    # for _ in range(10):
        # do_some_cpu_work()
        # do_some_io_work()
    print(f"time: {time.perf_counter() - start:.4f}s")

if __name__ == "__main__":
    main()
