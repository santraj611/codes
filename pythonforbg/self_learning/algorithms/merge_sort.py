# merge sort is a sorting algorithm
# which sorts array by resursion

# if only one number
    # quit
# else
    # sort left half of the numbers
    # sort right half of the numbers
    # merge sorted halves


def merge_sort(numbers: list[int]) -> list[int]:
    if len(numbers) < 2:
        return numbers

    mid = len(numbers) // 2
    left_halve = numbers[:mid]
    right_halve = numbers[mid:]

    sorted_left_halve = merge_sort(left_halve)
    sorted_right_halve = merge_sort(right_halve)

    return merge(sorted_left_halve, sorted_right_halve)

def merge(left_halve: list[int], right_halve: list[int]) -> list[int]:
    # compare both the list to form new list
    sorted_list: list[int] = list()
    l, r = 0, 0
    while (l < len(left_halve)) and (r < len(right_halve)):
        if left_halve[l] < right_halve[r]:
            sorted_list.append(left_halve[l])
            l += 1
        else:
            sorted_list.append(right_halve[r])
            r += 1

    sorted_list.extend(left_halve[l:])
    sorted_list.extend(right_halve[r:])

    return sorted_list
