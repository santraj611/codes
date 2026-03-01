nums = [1, 2, 3]
total = 0

for i in nums:
    total += i
    if i == 2:
        del nums[i]

print(total)
