class ApplicationMailer < ActionMailer::Base

# ===========================全体のメール設定====================================
default from:     'portfolioサイトからのご連絡です',# 	メールの送り主の名前
        bcc:      ENV['MAIL_ADDRESS_KEY'],# BCCで同時に送る宛先
        reply_to: ENV['MAIL_ADDRESS_KEY']# 返信した場合の受信先アドレス

# レイアウトはviews/layoutsのyield部分の大元のファイルを無理やり指定できる
layout 'mailer'
# ===========================================================================
end
