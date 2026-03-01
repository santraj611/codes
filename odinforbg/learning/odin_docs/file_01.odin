package main

import "core:fmt"
import "core:os"

main :: proc() {
    file_name: string = "messages.txt"
    file, err := os.open(file_name, os.O_RDONLY, 0)
    if err != 0 {
        fmt.printfln("Failed to open %s (error = %v)", file_name, err)
        return
    }
    defer os.close(file)

    BUF_SIZE :: 8
    buf: [BUF_SIZE]byte

    for {
        n, err := os.read(file, buf[:])
        if err != nil {
            if err == os.ERROR_EOF {
                break
            } else {
                fmt.printfln("Error reading file: %v", err)
                os.exit(-1)
            }
        }
        if n == 0 {
            // no more bytes
            break
        }
        fmt.printfln("read: %s", string(buf[:n]))
    }
}
