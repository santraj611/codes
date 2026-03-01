x = 0
def outer():
    x = 1
    def inner():
        x = 2
        print("inner:", x)

    inner()
    print("outer:", x)

outer()
print("global:", x)

# inner: 2
# outer: 1
# global: 0

########################################
x = 0
def outer():
    x = 1
    def inner():
        # nonlocal get the value of x from nearest nested loop
        # instead of creating a new variable
        nonlocal x
        x = 2
        print("inner:", x)

    inner()
    print("outer:", x)

outer()
print("global:", x)

# inner: 2
# outer: 2
# global: 0

########################################
x = 0
def outer():
    x = 1
    def inner():
        # global get the value of x from the global
        # instead of creating a new variable
        global x
        x = 2
        print("inner:", x)
        
    inner()
    print("outer:", x)

outer()
print("global:", x)

# inner: 2
# outer: 1
# global: 2

########################################
x = 10
def outer():
    x = 20
    def inner():
        nonlocal x
        x += 5
        print("inner:", x)
        return x
    print("outer:", x)
    return inner

f = outer()
print(f(), x)

# inner: 25
# outer: 25
# global: 10

