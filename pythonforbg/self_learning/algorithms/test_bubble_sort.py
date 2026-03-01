import unittest
from bubble_sort import bubble_sort   # replace with your actual module name

class TestBubbleSort(unittest.TestCase):

    def test_empty_list(self):
        arr = []
        bubble_sort(arr)
        self.assertEqual(arr, [])

    def test_single_element(self):
        arr = [5]
        bubble_sort(arr)
        self.assertEqual(arr, [5])

    def test_already_sorted(self):
        arr = [1, 2, 3, 4, 5]
        bubble_sort(arr)
        self.assertEqual(arr, [1, 2, 3, 4, 5])

    def test_reverse_sorted(self):
        arr = [5, 4, 3, 2, 1]
        bubble_sort(arr)
        self.assertEqual(arr, [1, 2, 3, 4, 5])

    def test_unsorted_list(self):
        arr = [64, 25, 12, 22, 11]
        bubble_sort(arr)
        self.assertEqual(arr, [11, 12, 22, 25, 64])

    def test_with_duplicates(self):
        arr = [3, 1, 2, 3, 1]
        bubble_sort(arr)
        self.assertEqual(arr, [1, 1, 2, 3, 3])

    def test_with_negative_numbers(self):
        arr = [3, -1, 0, -2, 5]
        bubble_sort(arr)
        self.assertEqual(arr, [-2, -1, 0, 3, 5])

    def test_large_list(self):
        arr = list(range(500, 0, -1))
        bubble_sort(arr)
        self.assertEqual(arr, list(range(1, 501)))

    def test_return_value_is_none(self):
        arr = [3, 2, 1]
        result = bubble_sort(arr)
        self.assertIsNone(result, "bubble_sort should not return anything")

if __name__ == "__main__":
    unittest.main()
