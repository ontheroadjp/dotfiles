function _ftp_to_nutsllc {
    lftp -e "mirror -R --delete --verbose ./dist /nutsllc.jp; quit" -u but.jp-nutstokyo,Xiaozhe0421 ftp.lolipop.jp
}
alias ftpnutsllc=_ftp_to_nutsllc
alias nutsllc="open https://nutsllc.jp"

alias em="open https://webmail.lolipop.jp/mail/INBOX"
