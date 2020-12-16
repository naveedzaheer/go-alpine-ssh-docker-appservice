package main

import (
	"io"
	"log"
	"net"
	"net/http"
)

func getLocalIP() net.IP {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		log.Fatal("Could not get connection information from Dial: ", err)
	}
	defer conn.Close()

	return conn.LocalAddr().(*net.UDPAddr).IP
}

func hello(writer http.ResponseWriter, req *http.Request) {
	io.WriteString(writer, "Hello, world!\n")
}

func main() {
	http.HandleFunc("/hello", hello)
	log.Fatal(http.ListenAndServe(getLocalIP().String()+":8080", nil))
}
