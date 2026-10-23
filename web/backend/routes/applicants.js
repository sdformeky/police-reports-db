const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM applicants ORDER BY id_applicant'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const {
            user_id,
            first_name,
            middle_name,
            surname_name,
            birth_date,
            res_address,
            email,
            phone_number
        } = req.body;

        if (!first_name || !surname_name || !birth_date || !res_address || !phone_number) {
            return res.status(400).json({ error: "missing fields" });
        }

        const result = await pool.query(
            `INSERT INTO applicants
            (user_id, first_name, middle_name, surname_name, birth_date, res_address, email, phone_number)
            VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
            RETURNING *`,
            [user_id, first_name, middle_name, surname_name, birth_date, res_address, email, phone_number]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM applicants WHERE id_applicant = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;