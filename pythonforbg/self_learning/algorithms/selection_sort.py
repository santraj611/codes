### selection sort
# In selection sort we find the smallest element
# and bring it to the start of the list

# for i from 0 to n-1:
    # find the smallest number between numbers[i] and numbers[n-1]
    # swap smallest number with numbers[i]

def selection_sort(arr: list[int]) -> None:
    n = len(arr)
    for i in range(n - 1):
      
        # Assume the current position holds
        # the minimum element
        min_idx = i
        
        # Iterate through the unsorted portion
        # to find the actual minimum
        for j in range(i + 1, n):
            if arr[j] < arr[min_idx]:
              
                # Update min_idx if a smaller element is found
                min_idx = j
        
        # Move minimum element to its
        # correct position
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
