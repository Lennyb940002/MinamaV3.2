const mongoose = require('mongoose');
const mysql = require('mysql2/promise');

// Configuration MongoDB
const connectMongoDB = async () => {
    try {
        await mongoose.connect(process.env.MONGODB_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log('Connexion MongoDB établie');
    } catch (error) {
        console.error('Erreur de connexion MongoDB:', error);
        process.exit(1);
    }
};

// Configuration MySQL
const connectMySQL = async () => {
    try {
        const connection = await mysql.createConnection({
            host: process.env.MYSQL_HOST,
            user: process.env.MYSQL_USER,
            password: process.env.MYSQL_PASSWORD,
            database: process.env.MYSQL_DATABASE
        });
        console.log('Connexion MySQL établie');
        return connection;
    } catch (error) {
        console.error('Erreur de connexion MySQL:', error);
        process.exit(1);
    }
};

module.exports = {
    connectMongoDB,
    connectMySQL
};