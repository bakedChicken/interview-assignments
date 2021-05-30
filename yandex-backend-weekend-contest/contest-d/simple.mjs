import http from 'http';

const requestListener = function (req, res) {
  res.writeHead(200);
  res.end('[1, 2, 3, 4, -5]');
}

const server = http.createServer(requestListener);
server.listen(7777);