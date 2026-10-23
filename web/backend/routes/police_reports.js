const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM police_reports ORDER BY id_report'
        );

        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const {
            applicant_id,
            time_place_id,
            requests,
            familiarw_article,
            report_date,
            report_time,
            applying_methods_id,
            employee_id,
            urgency
        } = req.body;

        if (
            !applicant_id ||
            !time_place_id ||
            requests === undefined ||
            familiarw_article === undefined ||
            !report_date ||
            !report_time ||
            !applying_methods_id ||
            !employee_id ||
            urgency === undefined
        ) {
            return res.status(400).json({ error: "missing fields" });
        }

        const result = await pool.query(
            `INSERT INTO police_reports
            (
                applicant_id,
                time_place_id,
                requests,
                familiarw_article,
                report_date,
                report_time,
                applying_methods_id,
                employee_id,
                urgency
            )
            VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
            RETURNING *`,
            [
                applicant_id,
                time_place_id,
                requests,
                familiarw_article,
                report_date,
                report_time,
                applying_methods_id,
                employee_id,
                urgency
            ]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM police_reports WHERE id_report = $1',
            [req.params.id]
        );

        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;