const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM reports_info ORDER BY id_reports_info'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const { incr_articles_id, report_id } = req.body;

        if (!incr_articles_id || !report_id) {
            return res.status(400).json({ error: "missing fields" });
        }

        const result = await pool.query(
            `INSERT INTO reports_info (incr_articles_id, report_id)
             VALUES ($1,$2)
             RETURNING *`,
            [incr_articles_id, report_id]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM reports_info WHERE id_reports_info = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;