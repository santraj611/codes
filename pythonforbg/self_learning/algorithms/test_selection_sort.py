import unittest
from selection_sort import selection_sort

class TestSelectionSort(unittest.TestCase):

    def test_empty_list(self):
        arr = []
        selection_sort(arr)
        self.assertEqual(arr, [])

    def test_single_element(self):
        arr = [5]
        selection_sort(arr)
        self.assertEqual(arr, [5])

    def test_already_sorted(self):
        arr = [1, 2, 3, 4, 5]
        selection_sort(arr)
        self.assertEqual(arr, [1, 2, 3, 4, 5])

    def test_reverse_sorted(self):
        arr = [5, 4, 3, 2, 1]
        selection_sort(arr)
        self.assertEqual(arr, [1, 2, 3, 4, 5])

    def test_unsorted_list(self):
        arr = [64, 25, 12, 22, 11]
        selection_sort(arr)
        self.assertEqual(arr, [11, 12, 22, 25, 64])

    def test_with_duplicates(self):
        arr = [3, 1, 2, 3, 1]
        selection_sort(arr)
        self.assertEqual(arr, [1, 1, 2, 3, 3])

    def test_with_negative_numbers(self):
        arr = [3, -1, 0, -2, 5]
        selection_sort(arr)
        self.assertEqual(arr, [-2, -1, 0, 3, 5])

    def test_large_list(self):
        arr = list(range(1000, 0, -1))
        selection_sort(arr)
        self.assertEqual(arr, list(range(1, 1001)))

    def test_return_value_is_none(self):
        arr = [3, 2, 1]
        result = selection_sort(arr)
        self.assertIsNone(result, "selection_sort should not return anything")

if __name__ == "__main__":
    unittest.main()
