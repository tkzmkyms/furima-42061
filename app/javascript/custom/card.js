const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return; // フォームがなければ処理を中断

  // フォームのdata属性から公開鍵を取得し、Payjpオブジェクトを初期化
  const payjpPublicKey = form.dataset.payjpPublicKey;
  const payjp = Payjp(payjpPublicKey);

  // PayjpのElementsを作成し、カード入力フォームをマウント
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  // 購入ボタンを取得し、クリック時の処理を設定
  const submitButton = document.getElementById("button");

  submitButton.addEventListener("click", (e) => {
    e.preventDefault(); // フォームの通常送信をキャンセル


    // Payjpにカード情報のトークンを作成依頼（numberElementを渡す）
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
       // ここでは何もしない（またはメッセージを表示しても良いが送信は止めない）
        form.submit(); // トークン無しで送信させる
        return;
      }

      // トークン作成成功時の処理

      // トークンをhidden inputとしてフォームに追加
      const token = response.id;
      const tokenInputHTML = `<input type="hidden" name="order_address[token]" value="${token}">`;
      form.insertAdjacentHTML("beforeend", tokenInputHTML);

      // セキュリティのためカード入力フォームのiframeをアンマウント（削除）
      numberElement.unmount();
      expiryElement.unmount();
      cvcElement.unmount();

      // トークンを含めたフォームをサーバーに送信
      form.submit();
    });
  });
};

// Turbo対応。ページロード後にpay関数を実行
window.addEventListener("turbo:load", pay);
