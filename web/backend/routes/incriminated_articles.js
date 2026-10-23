const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM incriminated_articles ORDER BY id_incr_articles'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const { incriminated_article } = req.body;

        if (!incriminated_article) {
            return res.status(400).json({ error: "missing field" });
        }

        const result = await pool.query(
            `INSERT INTO incriminated_articles (incriminated_article)
             VALUES ($1)
             RETURNING *`,
            [incriminated_article]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM incriminated_articles WHERE id_incr_articles = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;