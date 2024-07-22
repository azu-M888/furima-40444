document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('item-price').addEventListener('input', () => {
    const inputPrice = document.getElementById('item-price').value;

    const addTaxPrice = Math.floor(inputPrice * 0.1);
    document.getElementById('add-tax-price').innerText = addTaxPrice;

    const profit = Math.floor(inputPrice - addTaxPrice);
    document.getElementById('profit').innerText = profit;
  });
});
