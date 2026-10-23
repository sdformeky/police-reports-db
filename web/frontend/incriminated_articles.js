const list = document.getElementById('list');

async function loadArticles() {

    const res =
        await fetch('http://localhost:3000/incriminated-articles');

    const data = await res.json();

    list.innerHTML = '';

    data.forEach(a => {

        const div = document.createElement('div');

        div.className = 'card';

        div.innerHTML = `
            <h3>${a.incriminated_article}</h3>

            <button onclick="deleteArticle(${a.id_incr_articles})">
                Delete
            </button>
        `;

        list.appendChild(div);
    });
}

async function addArticle() {

    const incriminated_article =
        document.getElementById('incriminated_article').value;

    await fetch('http://localhost:3000/incriminated-articles/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            incriminated_article
        })
    });

    loadArticles();
}

async function deleteArticle(id) {

    await fetch(
        `http://localhost:3000/incriminated-articles/delete/${id}`,
        {
            method: 'DELETE'
        }
    );

    loadArticles();
}

document.addEventListener(
    'DOMContentLoaded',
    loadArticles
);