const list = document.getElementById('list');

async function loadTimePlace() {

    const res =
        await fetch('http://localhost:3000/time-place');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(t => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${t.violence_place}</h3>

            <p>Date: ${t.violence_date}</p>
            <p>Time: ${t.violence_time}</p>

            <button onclick="deleteTimePlace(${t.id_time_place})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addTimePlace() {

    const violence_time =
        document.getElementById('violence_time').value;

    const violence_date =
        document.getElementById('violence_date').value;

    const violence_place =
        document.getElementById('violence_place').value;

    await fetch('http://localhost:3000/time-place/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            violence_time,
            violence_date,
            violence_place
        })
    });

    loadTimePlace();
}

async function deleteTimePlace(id) {

    await fetch(
        `http://localhost:3000/time-place/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadTimePlace();
}

document.addEventListener(
    'DOMContentLoaded',
    loadTimePlace
);