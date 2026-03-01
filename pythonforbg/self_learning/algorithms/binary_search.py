def search(n: int, lst: list[int]) -> bool:
    """
    binary search, searches for n in sorted list
    """
    # if the list is empty return false
    if len(lst) == 0: return False

    start = 0
    end = len(lst)
    while start < end:
        mid = (start + end) // 2

        # check if n is the mid number
        if n == lst[mid]:
            return True

        # check if n is in the right side?
        # search the lst from mid+1 to n-1 (to the end)
        if n > lst[mid]:
            # if is then move start to middle
            start = mid + 1

        # otherwise it would be on left side
        # search lst from 0 to mid-1
        else:
            # if is then set end to mid + 1
            end = mid - 1

    # n is not in the list
    return False
