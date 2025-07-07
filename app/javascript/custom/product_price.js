const price = () => {
  const priceInput = document.getElementById("product-price");
  if (!priceInput) return;

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    if (inputValue) {
      const tax = Math.floor(inputValue * 0.1);
      const profit = inputValue - tax;
      addTaxDom.innerHTML = tax;
      profitDom.innerHTML = profit;
    } else {
      addTaxDom.innerHTML = '';
      profitDom.innerHTML = '';
    }
  });
};


window.addEventListener("turbo:load", price);

window.addEventListener("turbo:render", price);

