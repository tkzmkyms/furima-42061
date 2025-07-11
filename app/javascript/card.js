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
  console.log("✅ カード番号フォームをマウント完了");

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');
  console.log("✅ 有効期限フォームをマウント完了");

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');
  console.log("✅ CVCフォームをマウント完了");

  // 購入ボタンを取得し、クリック時の処理を設定
  const submitButton = document.getElementById("button");

  submitButton.addEventListener("click", (e) => {
    e.preventDefault(); // フォームの通常送信をキャンセル
    console.log("購入ボタンが押された！");

    // Payjpにカード情報のトークンを作成依頼（numberElementを渡す）
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        // トークン作成失敗時のエラーハンドリング
        alert("カード情報が正しくありません");
        console.error("Token取得失敗", response.error);
        return;
      }

      // トークン作成成功時の処理
      console.log("Token取得成功");
      console.log(response); // トークン情報をコンソールで確認可能

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
