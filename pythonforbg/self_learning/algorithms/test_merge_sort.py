import unittest
from merge_sort import merge_sort

class TestMergeSort(unittest.TestCase):

    def test_empty_list(self):
        arr = []
        result = merge_sort(arr)
        self.assertEqual(result, [])
        self.assertEqual(arr, [], "Original list should remain unchanged")

    def test_single_element(self):
        arr = [42]
        result = merge_sort(arr)
        self.assertEqual(result, [42])
        self.assertEqual(arr, [42])

    def test_already_sorted(self):
        arr = [1, 2, 3, 4, 5]
        result = merge_sort(arr)
        self.assertEqual(result, [1, 2, 3, 4, 5])
        self.assertEqual(arr, [1, 2, 3, 4, 5])

    def test_reverse_sorted(self):
        arr = [5, 4, 3, 2, 1]
        result = merge_sort(arr)
        self.assertEqual(result, [1, 2, 3, 4, 5])
        self.assertEqual(arr, [5, 4, 3, 2, 1], "Input should not be modified")

    def test_unsorted_list(self):
        arr = [38, 27, 43, 3, 9, 82, 10]
        result = merge_sort(arr)
        self.assertEqual(result, sorted(arr))

    def test_with_duplicates(self):
        arr = [5, 1, 4, 2, 5, 3, 1]
        result = merge_sort(arr)
        self.assertEqual(result, sorted(arr))

    def test_with_negative_numbers(self):
        arr = [3, -1, 0, -2, 5]
        result = merge_sort(arr)
        self.assertEqual(result, [-2, -1, 0, 3, 5])

    def test_large_list(self):
        arr = list(range(1000, 0, -1))
        result = merge_sort(arr)
        self.assertEqual(result, list(range(1, 1001)))

    def test_return_type(self):
        arr = [3, 2, 1]
        result = merge_sort(arr)
        self.assertIsInstance(result, list, "merge_sort should return a list")

if __name__ == "__main__":
    unittest.main()
