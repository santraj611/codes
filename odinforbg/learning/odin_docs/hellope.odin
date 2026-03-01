package main

import "core:fmt"

main :: proc() {
    // print Hellope!
    fmt.println("Hellope!")

    my_int: int // simple right?
    my_int = 10
    fmt.println(my_int)

    your_stupid_name: string = "Thor"
    fmt.printfln("You can shutup, you are just %d years old!", len(your_stupid_name))
	fmt.printfln("I know this is not how you calculate age.")
}
