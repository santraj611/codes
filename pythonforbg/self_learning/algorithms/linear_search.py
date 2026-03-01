def search(n: int, lst: list[int]) -> bool:
    """
    linear search
    Returns True if found else False
    """
    for i in range(0, len(lst)):
        if lst[i] == n:
            return True
    else:
        return False
