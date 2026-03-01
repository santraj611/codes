import sys


def main():
    x = "four"
    try:
        four = int(x) # this could failed
    except ValueError as e:
        print(f"Failed to change to an int type, Due to {e}")
        sys.exit(-1)

    print(f"x was converted to {four}")

if __name__ == "__main__":
    main()
