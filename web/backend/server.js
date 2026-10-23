const express = require('express');
const cors = require('cors');
const path = require('path');

require('dotenv').config();

const usersRoutes = require('./routes/users');
const applicantsRoutes = require('./routes/applicants');
const reportsRoutes = require('./routes/police_reports');
const employeesRoutes = require('./routes/employees');
const departmentsRoutes = require('./routes/departments');
const passportsRoutes = require('./routes/passports');
const applyingMethodsRoutes = require('./routes/applying_methods');
const incriminatedArticlesRoutes = require('./routes/incriminated_articles');
const timePlaceRoutes = require('./routes/time_place');
const reportsInfoRoutes = require('./routes/reports_info');

const app = express();

app.use(cors({
    origin: [
        'http://localhost:5500',
        'http://127.0.0.1:5500'
    ],
    methods: ['GET', 'POST', 'DELETE', 'PUT'],
    allowedHeaders: ['Content-Type']
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/users', usersRoutes);
app.use('/applicants', applicantsRoutes);
app.use('/reports', reportsRoutes);
app.use('/employees', employeesRoutes);
app.use('/departments', departmentsRoutes);
app.use('/passports', passportsRoutes);
app.use('/applying-methods', applyingMethodsRoutes);
app.use('/incriminated-articles', incriminatedArticlesRoutes);
app.use('/time-place', timePlaceRoutes);
app.use('/reports-info', reportsInfoRoutes);

app.use('/frontend', express.static(path.join(__dirname, '../frontend')));

const PORT = process.env.PORT || 5500;

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});