const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const payjpPublicKey = form.dataset.payjpPublicKey;
  const payjp = Payjp(payjpPublicKey);
  const elements = payjp.elements();

  // カード番号フォーム
  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');
  console.log("✅ カード番号フォームをマウント完了");

  // 有効期限フォーム
  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');
  console.log("✅ 有効期限フォームをマウント完了");

  // CVCフォーム
  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');
  console.log("✅ CVCフォームをマウント完了");

  const submitButton = document.getElementById("button");

  submitButton.addEventListener("click", (e) => {
    e.preventDefault();
    console.log("購入ボタンが押された！");

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert("カード情報が正しくありません");
        return;
      }

      console.log("Token取得成功");
      console.log(response); // ← 確認用


      const token = response.id;
      const tokenObj = `<input value="${token}" type="hidden" name="order_address[token]">`;
      form.insertAdjacentHTML("beforeend", tokenObj);

      // iframeのカード入力欄を削除（セキュリティ上）
      numberElement.unmount();
      expiryElement.unmount();
      cvcElement.unmount();

      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
