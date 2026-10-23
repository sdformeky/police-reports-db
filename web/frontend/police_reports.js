const list = document.getElementById('list');

async function loadReports() {
    const res = await fetch('http://localhost:3000/reports');
    const data = await res.json();

    list.innerHTML = '';

    data.forEach(r => {
        const div = document.createElement('div');
        div.className = 'card';

        div.innerHTML = `
            <h3>REPORT #${r.id_report}</h3>

            <p>Applicant: ${r.applicant_id}</p>
            <p>Time Place: ${r.time_place_id}</p>
            <p>Requests: ${r.requests}</p>
            <p>Familiar Article: ${r.familiarw_article}</p>
            <p>Date: ${r.report_date}</p>
            <p>Time: ${r.report_time}</p>
            <p>Applying Method: ${r.applying_methods_id}</p>
            <p>Employee: ${r.employee_id}</p>
            <p>Urgency: ${r.urgency}</p>

            <button onclick="deleteReport(${r.id_report})">Delete</button>
        `;

        list.appendChild(div);
    });
}

async function addReport() {

    const applicant_id = Number(document.getElementById('applicant_id').value);

    const time_place_id = Number(document.getElementById('time_place_id').value);

    const requests =
        document.getElementById('requests').value === 'true';

    const familiarw_article =
        document.getElementById('familiarw_article').value === 'true';

    const report_date =
        document.getElementById('report_date').value;

    const report_time =
        document.getElementById('report_time').value;

    const applying_methods_id =
        Number(document.getElementById('applying_methods_id').value);

    const employee_id =
        Number(document.getElementById('employee_id').value);

    const urgency =
        document.getElementById('urgency').value === 'true';

    await fetch('http://localhost:3000/reports/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            applicant_id,
            time_place_id,
            requests,
            familiarw_article,
            report_date,
            report_time,
            applying_methods_id,
            employee_id,
            urgency
        })
    });

    loadReports();
}

async function deleteReport(id) {
    await fetch(`http://localhost:3000/reports/delete/${id}`, {
        method: 'DELETE'
    });

    loadReports();
}

document.addEventListener('DOMContentLoaded', loadReports);