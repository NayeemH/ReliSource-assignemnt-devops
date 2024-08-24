const express = require('express');
const router = express.Router();
const mysql = require('mysql2/promise');
require('dotenv').config();

const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
};

// Endpoint to add a user
router.post('/users', async (req, res) => {
    const { name, email } = req.body;
    try {
        const connection = await mysql.createConnection(dbConfig);
        const [result] = await connection.execute(
            'INSERT INTO users (name, email) VALUES (?, ?)',
            [name, email]
        );
        await connection.end();
        res.status(201).json({ id: result.insertId, name, email });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Endpoint to retrieve users
router.get('/users', async (req, res) => {
    try {
        const connection = await mysql.createConnection(dbConfig);
        const [rows] = await connection.execute('SELECT * FROM users');
        await connection.end();
        res.status(200).json(rows);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
