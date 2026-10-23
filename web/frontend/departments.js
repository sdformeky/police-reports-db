// departments.js

const list = document.getElementById('list');

async function loadDepartments() {

    const res =
        await fetch('http://localhost:3000/departments');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(d => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${d.department}</h3>

            <button onclick="deleteDepartment(${d.id_department})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addDepartment() {

    const department =
        document.getElementById('department').value;

    await fetch('http://localhost:3000/departments/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ department })
    });

    loadDepartments();
}

async function deleteDepartment(id) {

    await fetch(
        `http://localhost:3000/departments/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadDepartments();
}

document.addEventListener(
    'DOMContentLoaded',
    loadDepartments
);