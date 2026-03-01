import unittest
from binary_search import search   # replace 'your_module' with your actual filename (without .py)

class TestBinarySearch(unittest.TestCase):

    def test_element_present_middle(self):
        lst = [1, 3, 5, 7, 9]
        self.assertTrue(search(5, lst))

    def test_element_present_first(self):
        lst = [1, 2, 3, 4, 5]
        self.assertTrue(search(1, lst))

    def test_element_present_last(self):
        lst = [1, 2, 3, 4, 5]
        self.assertTrue(search(5, lst))

    def test_element_absent_lower(self):
        lst = [10, 20, 30, 40, 50]
        self.assertFalse(search(5, lst))

    def test_element_absent_higher(self):
        lst = [10, 20, 30, 40, 50]
        self.assertFalse(search(60, lst))

    def test_empty_list(self):
        self.assertFalse(search(1, []))

    def test_single_element_found(self):
        self.assertTrue(search(42, [42]))

    def test_single_element_not_found(self):
        self.assertFalse(search(10, [42]))

    def test_duplicates(self):
        lst = [1, 2, 2, 2, 3, 4]
        self.assertTrue(search(2, lst))

    def test_large_sorted_list(self):
        big_list = list(range(1_000_000))
        self.assertTrue(search(999_999, big_list))
        self.assertFalse(search(1_000_001, big_list))

    def test_unsorted_list(self):
        lst = [3, 1, 4, 2]
        # Binary search assumes sorted input; result may be undefined
        # We check behavior remains consistent after sorting
        self.assertTrue(search(3, sorted(lst)))
        self.assertFalse(search(5, sorted(lst)))

if __name__ == "__main__":
    unittest.main()
