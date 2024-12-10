const express = require('express');
const mongoose = require('mongoose');
const mysql = require('mysql2');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');

// Charger les variables d'environnement
dotenv.config();

const app = express();

// Middlewares
app.use(cors());
app.use(bodyParser.json());

// Connexion à MongoDB
mongoose.connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(() => console.log('Connexion à MongoDB réussie'))
    .catch((err) => console.error('Échec de connexion à MongoDB', err));

// Connexion à MySQL
const mysqlConnection = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    port: process.env.MYSQL_PORT
});

mysqlConnection.connect((err) => {
    if (err) {
        console.error('Échec de connexion à MySQL:', err);
        return;
    }
    console.log('Connexion à MySQL réussie');
});

// Routes (à ajouter plus tard)
// app.use('/api/users', require('./routes/users'));
// app.use('/api/products', require('./routes/products'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Serveur démarré sur le port ${PORT}`);
});