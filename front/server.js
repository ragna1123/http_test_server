// script.js
document.getElementById('fetchDataButton').addEventListener('click', fetchData);

function fetchData() {
  // サーバーからデータを取得
  axios.get('http://localhost:3000/episodes')
    .then(response => {
      const dataContainer = document.getElementById('dataContainer');
      dataContainer.innerText = `Data from server: ${JSON.stringify(response.data)}`;
    })
    .catch(error => {
      console.error('Error fetching data:', error.message);
    });
}
