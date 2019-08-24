# -----------------------------------------
# 通常のsshポートは塞ぐ
# -----------------------------------------
echo "> close ssh(port 22) service"
firewall-cmd --remove-service=ssh --permanent

# -----------------------------------------
# IP Spoofing 対策
#（外部（WAN側）からプライベートIPアドレスに成りすました通信を破棄）
# -----------------------------------------
echo "> Protecting IP Spoofing Attack"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -s 127.0.0.1/8 -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -s 10.0.0.0/8 -j DROP #開発環境では許可
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -s 172.16.0.0/12 -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -s 192.168.0.0/16 -j DROP  #開発環境では許可
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -s 192.168.0.0/24  -j DROP #開発環境では許可

# -----------------------------------------
# Ping of Death & Ping Flood 対策
#（Ping 応答を1秒間に1セット（Ping は通常4回で1セット）に制限し、さらに 85 byte 以上のパケットを破棄）
# -----------------------------------------
echo "> Protecting Ping of Death & Ping Flood Attack"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p icmp --icmp-type 8 -m length --length :85 -m limit --limit 1/s --limit-burst 4 -j ACCEPT

# -----------------------------------------
# ブロードキャストアドレスを破棄する
# -----------------------------------------
echo "> Reject broad cast address packets"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m pkttype --pkt-type broadcast -j DROP

# -----------------------------------------
# マルチキャストアドレスを破棄する
# -----------------------------------------
echo "> Reject multi cast address packets"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m pkttype --pkt-type multicast -j DROP

# -----------------------------------------
# SYNflood攻撃と思われる接続を破棄する
# -----------------------------------------
echo "> Reject packets may be SYNflood attack"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp ! --syn -m state --state NEW -j DROP

# -----------------------------------------
# TCP SYN Flood 攻撃対策
# SYN Cookiesを有効にする
# -----------------------------------------
echo "> Protecting TCP SYN Flood Attack"
sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=1" >> /etc/sysctl.conf

# データを持たないパケットの接続を破棄する
firewall-cmd  --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags ALL NONE -j DROP

# ステルススキャンと思われる接続を破棄する
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags ALL ALL -j DROP

# -----------------------------------------
# Smurf の踏み台対策
# （ブロードキャスト宛の Ping に応答しない）
# -----------------------------------------
echo "> Protecting Smurf Attack"
sed -i '/net.ipv4.icmp_echo_ignore_broadcasts/d' /etc/sysctl.conf
echo “net.ipv4.icmp_echo_ignore_broadcasts=1” >> /etc/sysctl.conf

# -----------------------------------------
# Pingに不要なicmpタイプのブロック(echo-request、echo-reply 以外)
# -----------------------------------------
echo "> Reject unused icmp type packets"
firewall-cmd --permanent --add-icmp-block=destination-unreachable
firewall-cmd --permanent --add-icmp-block=parameter-problem
firewall-cmd --permanent --add-icmp-block=redirect
firewall-cmd --permanent --add-icmp-block=router-advertisement
firewall-cmd --permanent --add-icmp-block=router-solicitation
firewall-cmd --permanent --add-icmp-block=source-quench
firewall-cmd --permanent --add-icmp-block=time-exceeded

# -----------------------------------------
# invalid パケットを破棄
# -----------------------------------------
echo "> Reject invalid packets"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m state --state INVALID -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -m state --state INVALID -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -m state --state INVALID -j DROP

# -----------------------------------------
# Ping of Death 攻撃対策（firewall-cmdに修正するのがめんどくなったので割愛。参考サイトを参照してください。）
# -----------------------------------------

# -----------------------------------------
# flooding of RST packets, smurf attack Rejection
# -----------------------------------------
echo "> Protecting flooding of RST packets, smurf attack Rejection"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT

# -----------------------------------------
# Protecting portscans
# Attacking IP will be locked for 24 hours (3600 x 24 = 86400 Seconds)
# -----------------------------------------
echo "> Protecting port scan"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m recent --name portscan --rcheck --seconds 86400 -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -m recent --name portscan --rcheck --seconds 86400 -j DROP

# -----------------------------------------
# Remove attacking IP after 24 hours
# -----------------------------------------
echo "> Remove attacking IP address after 24 hours"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m recent --name portscan --remove
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD  0 -m recent --name portscan --remove

# -----------------------------------------
# ICMP Redirectパケットは拒否
# -----------------------------------------
echo "> Reject ICMP redirect packets"
sed -i '/net.ipv4.conf.*.accept_redirects/d' /etc/sysctl.conf
sed -i '/net.ipv6.conf.*.accept_redirects/d' /etc/sysctl.conf

for dev in $(ls /proc/sys/net/ipv4/conf/); do
    sysctl -w net.ipv4.conf.$dev.accept_redirects=0 > /dev/null
    echo "net.ipv4.conf.$dev.accept_redirects=0" >> /etc/sysctl.conf
done

for dev in $(ls /proc/sys/net/ipv6/conf/); do
    sysctl -w net.ipv6.conf.$dev.accept_redirects=0 > /dev/null
    echo "net.ipv6.conf.$dev.accept_redirects=0" >> /etc/sysctl.conf
done

# -----------------------------------------
# Source Routedパケットは拒否
# -----------------------------------------
echo "> Reject Source Routed packets"
sed -i '/net.ipv4.conf.*.accept_source_route/d' /etc/sysctl.conf

for dev in $(ls /proc/sys/net/ipv4/conf/); do
    sysctl -w net.ipv4.conf.$dev.accept_source_route=0 > /dev/null
    echo “net.ipv4.conf.$dev.accept_source_route=0” >> /etc/sysctl.conf
done

# -----------------------------------------
# ポート開放
# -----------------------------------------

# SSH ポート開放
echo "> open port 10314"
firewall-cmd --add-port=10314/tcp --permanent  # 10022番の通信許可

# http サービス(#80)開放
echo "> add HTTP service(port 80)"
firewall-cmd --add-service=http --permanent

# https サービス(#80)開放
echo "> add HTTPS service(port 443)"
firewall-cmd --add-service=https --permanent

# -----------------------------------------
# ルールに当てはまらない受信を破棄(これで、INPUT、FORWARD両方にDROP)
# sshの接続が確認されてから行う事。（でないと、ターミナルからログインできなくなる。）
# -----------------------------------------
echo "> Reject all packets"
firewall-cmd --permanent --set-target=DROP

# -----------------------------------------
# firewalld 再起動
# -----------------------------------------
echo "> Restart firewalld."
firewall-cmd --reload

echo "> complete!"
