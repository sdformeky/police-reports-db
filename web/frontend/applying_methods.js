const list = document.getElementById('list');

async function loadMethods() {

    const res =
        await fetch('http://localhost:3000/applying-methods');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(m => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${m.applying_method}</h3>

            <button onclick="deleteMethod(${m.id_applying_methods})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addMethod() {

    const applying_method =
        document.getElementById('applying_method').value;

    await fetch('http://localhost:3000/applying-methods/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            applying_method
        })
    });

    loadMethods();
}

async function deleteMethod(id) {

    await fetch(
        `http://localhost:3000/applying-methods/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadMethods();
}

document.addEventListener(
    'DOMContentLoaded',
    loadMethods
);