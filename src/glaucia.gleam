import glisten/socket/options.{ActiveMode, Passive}
import glisten/tcp

import gleam/io
import gleam/result
import gleam/bytes_builder

pub fn main() {
  use listener <- result.then(tcp.listen(3000, [ActiveMode(Passive)]))
  io.debug("Listening on the port 3000")

  accept(listener)
}

fn accept(listener) {
  use socket <- result.then(tcp.accept(listener))
  io.debug("Request received")
  let _request = tcp.receive(socket, 0)

  let _ = tcp.send(socket, bytes_builder.from_string("HTTP/2 200\r\nContent-Type: text/html\r\n\r\n<h1>Hello World</h1>"))
  let _ = tcp.close(socket)

  accept(listener)
}
