package main

import "core:fmt"
import "core:os"
import "core:strings"

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

	line_buffer, _ := strings.builder_make()
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
		// if n == 0 {
		//     // no more bytes
		//     break
		// }

		// Add this chunk to the buffer
		strings.write_string(&line_buffer, string(buf[:n]))

		// convert buffer to string to scan for new lines
		data: string = strings.to_string(line_buffer)
		start: uint = 0
		for i in 0 ..< len(data) {
			// look for new line
			if data[i] == '\n' {
				line := data[start:i]
				fmt.printfln("read: %s", line)
				start = uint(i + 1)
			}
		}

		// Keep any leftover partial line after the last '\n'
		if start < len(data) {
			remaining := data[start:]
			strings.builder_reset(&line_buffer)
			strings.write_string(&line_buffer, remaining)
		} else {
			strings.builder_reset(&line_buffer)
		}
	}

	// At EOF, if there’s any leftover without '\n', print it too
	if strings.builder_len(line_buffer) > 0 {
		fmt.printfln("line: %s", strings.to_string(line_buffer))
	}

	strings.builder_destroy(&line_buffer)
}
