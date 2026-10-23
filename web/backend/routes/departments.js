const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM departments ORDER BY id_department'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const { department } = req.body;

        if (!department) {
            return res.status(400).json({ error: "missing field" });
        }

        const result = await pool.query(
            `INSERT INTO departments (department)
             VALUES ($1)
             RETURNING *`,
            [department]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM departments WHERE id_department = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;