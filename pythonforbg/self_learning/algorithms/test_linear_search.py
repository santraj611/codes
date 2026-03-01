import unittest
from linear_search import search

class TestSearchFunction(unittest.TestCase):

    def test_element_present(self):
        self.assertTrue(search(3, [1, 2, 3, 4, 5]))

    def test_element_absent(self):
        self.assertFalse(search(6, [1, 2, 3, 4, 5]))

    def test_empty_list(self):
        self.assertFalse(search(1, []))

    def test_single_element_found(self):
        self.assertTrue(search(10, [10]))

    def test_single_element_not_found(self):
        self.assertFalse(search(10, [5]))

    def test_negative_numbers(self):
        self.assertTrue(search(-3, [-1, -2, -3]))
        self.assertFalse(search(-4, [-1, -2, -3]))

    def test_duplicates(self):
        self.assertTrue(search(2, [1, 2, 2, 3]))

    def test_large_list(self):
        big_list = list(range(1_000_000))
        self.assertTrue(search(999_999, big_list))
        self.assertFalse(search(1_000_001, big_list))

if __name__ == "__main__":
    unittest.main()
