const list = document.getElementById('list');

async function loadApplicants() {
    const res = await fetch('http://localhost:3000/applicants');
    const data = await res.json();

    list.innerHTML = '';

    data.forEach(a => {
        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${a.first_name} ${a.surname_name}</h3>

            <p>User: ${a.user_id}</p>
            <p>Middle: ${a.middle_name}</p>
            <p>Birth: ${a.birth_date}</p>
            <p>Address: ${a.res_address}</p>
            <p>Email: ${a.email}</p>
            <p>Phone: ${a.phone_number}</p>

            <button onclick="deleteApplicant(${a.id_applicant})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addApplicant() {

    const user_id =
        Number(document.getElementById('user_id').value);

    const first_name =
        document.getElementById('first_name').value;

    const middle_name =
        document.getElementById('middle_name').value;

    const surname_name =
        document.getElementById('surname_name').value;

    const birth_date =
        document.getElementById('birth_date').value;

    const res_address =
        document.getElementById('res_address').value;

    const email =
        document.getElementById('email').value;

    const phone_number =
        document.getElementById('phone_number').value;

    await fetch('http://localhost:3000/applicants/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            user_id,
            first_name,
            middle_name,
            surname_name,
            birth_date,
            res_address,
            email,
            phone_number
        })
    });

    loadApplicants();
}

async function deleteApplicant(id) {
    await fetch(
        `http://localhost:3000/applicants/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadApplicants();
}

document.addEventListener(
    'DOMContentLoaded',
    loadApplicants
);