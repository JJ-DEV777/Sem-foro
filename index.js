// index.js
const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json()); // já substitui body-parser json

// Dados em memória
let logs = [];
let registros = [];
let usuarios = [];
let acoesUsuario = [];

// Rota para registrar ações gerais
app.post('/acao', (req, res) => {
  const { usuario, acao } = req.body;
  if (!usuario || !acao) {
    return res.status(400).json({ sucesso: false, mensagem: 'Dados incompletos' });
  }
  const timestamp = new Date().toISOString();
  const registro = { usuario, acao, timestamp };

  console.log('Ação recebida:', registro);
  logs.push(registro);

  res.status(200).json({ mensagem: 'Ação registrada com sucesso!' });
});

// Rota para pegar logs
app.get('/logs', (req, res) => {
  res.json(logs);
});

// Rota de login
const usuariosPermitidos = {
  admin: '123456',
  lilian: 'senha123',
  iasmin: 'senha456',
  wlad: 'senha789',
  savio: 'senha321',
  wesley: 'senha654',
  jason: 'senha987',
};

app.post('/login', (req, res) => {
  const { nome, senha } = req.body;

  if (usuariosPermitidos[nome] && usuariosPermitidos[nome] === senha) {
    return res.status(200).json({ sucesso: true, mensagem: `Bem-vindo, ${nome}!` });
  } else {
    return res.status(401).json({ sucesso: false, mensagem: 'Nome ou senha inválidos.' });
  }
});

// Rota para slider
app.post('/slider', (req, res) => {
  const { usuario, inicio, fim } = req.body;

  if (!usuario || inicio === undefined || fim === undefined) {
    return res.status(400).json({ sucesso: false, mensagem: 'Dados inválidos' });
  }

  registros.push({ usuario, inicio, fim, data: new Date().toISOString() });

  console.log(`Ação recebida do ${usuario}: Range ${inicio} - ${fim}`);

  return res.status(200).json({ sucesso: true, mensagem: 'Valores registrados com sucesso' });
});

// Rota para registro de novos usuários
app.post('/registro', (req, res) => {
  const { nome, telefone, email, senha } = req.body;

  if (!nome || !telefone || !email || !senha || senha.length < 6) {
    return res.status(400).json({ sucesso: false, mensagem: 'Dados inválidos ou incompletos' });
  }

  // Verificar se email já existe
  const usuarioExiste = usuarios.find(u => u.email === email);
  if (usuarioExiste) {
    return res.status(400).json({ sucesso: false, mensagem: 'Email já cadastrado' });
  }

  usuarios.push({ nome, telefone, email, senha });
  console.log(`Usuário cadastrado: ${nome} (${email})`);

  return res.status(201).json({ sucesso: true, mensagem: 'Usuário cadastrado com sucesso!' });
});

// Rota para registrar ações do usuário
app.post('/registrar-acao', (req, res) => {
  const { usuario, acao } = req.body;

  if (!usuario || !acao) {
    return res.status(400).json({ sucesso: false, mensagem: 'Dados incompletos' });
  }

  const registro = {
    usuario,
    acao,
    data: new Date().toISOString(),
  };

  acoesUsuario.push(registro);

  console.log('Ação registrada:', registro);

  return res.json({ sucesso: true, mensagem: 'Ação registrada com sucesso!' });
});

// Inicia servidor uma única vez
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
