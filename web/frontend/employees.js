const list = document.getElementById('list');

async function loadEmployees() {

    const res =
        await fetch('http://localhost:3000/employees');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(e => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${e.emp_surname} ${e.emp_name}</h3>

            <p>Middle: ${e.emp_middle_name}</p>
            <p>Department: ${e.department_id}</p>
            <p>Passport: ${e.passport_id}</p>

            <button onclick="deleteEmployee(${e.id_employees})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addEmployee() {

    const emp_surname =
        document.getElementById('emp_surname').value;

    const emp_name =
        document.getElementById('emp_name').value;

    const emp_middle_name =
        document.getElementById('emp_middle_name').value;

    const department_id =
        Number(document.getElementById('department_id').value);

    const passport_id =
        Number(document.getElementById('passport_id').value);

    await fetch('http://localhost:3000/employees/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            emp_surname,
            emp_name,
            emp_middle_name,
            department_id,
            passport_id
        })
    });

    loadEmployees();
}

async function deleteEmployee(id) {

    await fetch(
        `http://localhost:3000/employees/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadEmployees();
}

document.addEventListener(
    'DOMContentLoaded',
    loadEmployees
);