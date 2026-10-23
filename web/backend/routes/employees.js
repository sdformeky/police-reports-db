const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/', async (req, res) => {
    try {
        const result = await pool.query(
            'SELECT * FROM employees ORDER BY id_employees'
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/add', async (req, res) => {
    try {
        const { emp_surname, emp_name, emp_middle_name, department_id, passport_id } = req.body;

        if (!emp_surname || !emp_name || !department_id || !passport_id) {
            return res.status(400).json({ error: "missing fields" });
        }

        const result = await pool.query(
            `INSERT INTO employees
            (emp_surname, emp_name, emp_middle_name, department_id, passport_id)
            VALUES ($1,$2,$3,$4,$5)
            RETURNING *`,
            [emp_surname, emp_name, emp_middle_name, department_id, passport_id]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/delete/:id', async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM employees WHERE id_employees = $1',
            [req.params.id]
        );
        res.json({ message: 'deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;