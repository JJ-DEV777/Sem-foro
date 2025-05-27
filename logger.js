const fs = require('fs');
const path = require('path');

const caminhoLog = path.join(__dirname, 'logs.json');

function registrarAcao(usuario, acao) {
  const registro = {
    usuario,
    acao,
    timestamp: new Date().toISOString()
  };

  let logs = [];
  if (fs.existsSync(caminhoLog)) {
    logs = JSON.parse(fs.readFileSync(caminhoLog));
  }

  logs.push(registro);

  fs.writeFileSync(caminhoLog, JSON.stringify(logs, null, 2));
}

module.exports = { registrarAcao };
