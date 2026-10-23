const list = document.getElementById('list');

async function loadReportsInfo() {

    const res =
        await fetch('http://localhost:3000/reports-info');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(r => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>REPORT INFO #${r.id_reports_info}</h3>

            <p>Article ID: ${r.incr_articles_id}</p>
            <p>Report ID: ${r.report_id}</p>

            <button onclick="deleteReportInfo(${r.id_reports_info})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addReportInfo() {

    const incr_articles_id =
        Number(document.getElementById('incr_articles_id').value);

    const report_id =
        Number(document.getElementById('report_id').value);

    await fetch('http://localhost:3000/reports-info/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            incr_articles_id,
            report_id
        })
    });

    loadReportsInfo();
}

async function deleteReportInfo(id) {

    await fetch(
        `http://localhost:3000/reports-info/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadReportsInfo();
}

document.addEventListener(
    'DOMContentLoaded',
    loadReportsInfo
);