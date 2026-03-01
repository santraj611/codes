package main

import "core:fmt"
import "core:net"
import "core:os"
import "core:strings"

main :: proc() {
	sokt, err := net.listen_tcp({address = net.IP4_Address{127, 0, 0, 1}, port = 8080})
	if err != nil {
		fmt.println("Oops, failed to create the socket!")
		return
	}
	defer net.close(sokt)
	fmt.println("Listening on localhost:8080")

	for {
		client, client_endpt, err := net.accept_tcp(sokt)
		if err != nil {
			fmt.println("Oops, Client is messing with you!")
			continue
		}

		fmt.printfln("Got a connection from %v:%v", client_endpt.address, client_endpt.port)
		handle_client(client)
	}
}

handle_client :: proc(client: net.TCP_Socket) {
	defer net.close(client)

	// read the http request
	buffer: [1024]u8
	bytes_read, err := net.recv_tcp(client, buffer[:])
	if err != nil {
		fmt.println("Failed to recv from client")
	}

	request: string = string(buffer[:bytes_read])
	fmt.printfln("Request:\n%v", request)

	index_file, file_open_err := os.open("index.html")
	if file_open_err != nil {
		fmt.println("Oops, Failed to open file")
	}
	file_buffer: [1024]u8
	b_read, read_err := os.read(index_file, file_buffer[:])
	if read_err != nil {
		fmt.printfln("Error reading file: %v", err)
		os.exit(-1)
	}

	response := strings.concatenate(
		[]string {
			"HTTP/1.1 200 OK\r\n",
			"Content-Type: text/html\r\n",
			"Connection: Close\r\n",
			"\r\n",
			string(file_buffer[:b_read]),
		},
	)


	bytes_written, send_err := net.send_tcp(client, transmute([]u8)response)
	if send_err != nil {
		fmt.println("Oops, Failed to send greetings!")
	}
}
