const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM passports ORDER BY id_passport'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const { serial, number } = req.body;

        if (!serial || !number) {
            return res.status(400).json({ error: "missing fields" });
        }

        const result = await pool.query(
            `INSERT INTO passports (serial, number)
             VALUES ($1,$2)
             RETURNING *`,
            [serial, number]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM passports WHERE id_passport = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;