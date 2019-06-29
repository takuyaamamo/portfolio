class PortfolioMailer < ApplicationMailer
  #個別のメール設定

 # 個別のメール設定をdefineで設定していく。それぞれ使いたい部分で関数を呼び出せば使えるんだと思う

 # ============================見本のdefine=====================================
 # 下記アクションを使用したい場合はPersonal.update_when_create(user).deliverと指定する
 def send_when_create(user)
   # テンプレートたちと、メーラーの関係は、viewとcontrollerと一緒。要するにこのアクションに対応するメールの中身はviews/personal_mailer/send_when_create.html.erb or txt.erb
   @user = user
   #mailはメソッド、mail toでは無いmailの中のto
   mail to:      user.email,# 送信先にuserのemailアドレス
        subject: 'こんにちは！新しいユーザーが追加されました'# 題名設定
 end
 #=============================================================================

# =============================お問い合わせフォーム送信=============================
# 下記メソッドを使用したい場合はPersonal.send_when_contact_to_user(@contact).deliverと指定する
 def send_when_buy(purchased)
   # 引き渡されるvalueに@を付けることでメール画面に反映させられる用にする
   @purchased_history = purchased
   @purchased_items = PurchasedItem.where(purchased_history_id: @purchased_history.id)
   @items_with_deleted = Item.with_deleted
   mail  to:      @purchased_history.email_address,
         from:    ENV['MAIL_ADDRESS_KEY'],
         bcc:      ENV['MAIL_ADDRESS_KEY'],
         subject: 'ご購入ありがとう御座います。DEMO'
 end
 #=============================================================================

end
