# bubble sort

# repeat n-1 times
    # for i from 0 to n-1
        # if numbers[i] and numbers[i+1] is out of order
        # swap them
    # if no swap
        # then quit


def bubble_sort(arr: list[int]) -> None:
    n = len(arr)
    for _ in range(n-1):
        swapped = False
        for i in range(n-1):
            if arr[i] > arr[i+1]:
                arr[i], arr[i+1] = arr[i+1], arr[i]
                swapped = True
        if not swapped:
            break
