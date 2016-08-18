let server = require('./agentHttpServer');

let closeServer;

a = server.agentHttpServer(3333)
  .then(c => { closeServer = c; })
  .catch(err => console.log(err));