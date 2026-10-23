const list = document.getElementById('list');

async function loadUsers() {
    const res = await fetch('http://localhost:3000/users');
    const data = await res.json();

    list.innerHTML = '';

    data.forEach(u => {
        const div = document.createElement('div');
        div.className = 'card';

        div.innerHTML = `
            <h3>${u.full_name}</h3>

            <p>Email: ${u.email}</p>
            <p>Login: ${u.login}</p>
            <p>Password: ${u.password}</p>
            <p>Role: ${u.role}</p>
            <p>Created: ${u.created_at}</p>

            <button onclick="deleteUser(${u.id})">Delete</button>
        `;

        list.appendChild(div);
    });
}

async function addUser() {

    const full_name =
        document.getElementById('full_name').value;

    const email =
        document.getElementById('email').value;

    const login =
        document.getElementById('login').value;

    const password =
        document.getElementById('password').value;

    const role =
        document.getElementById('role').value;

    await fetch('http://localhost:3000/users/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            full_name,
            email,
            login,
            password,
            role
        })
    });

    loadUsers();
}

async function deleteUser(id) {
    await fetch(`http://localhost:3000/users/delete/${id}`, {
        method: 'DELETE'
    });

    loadUsers();
}

document.addEventListener('DOMContentLoaded', loadUsers);