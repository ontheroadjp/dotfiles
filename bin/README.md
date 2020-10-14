# README.md

These files are shell script for the Shell and shown on tmux toolbar e.t.c.



### batterry

```bash
$ battery
86%
```



### colors

- show color sample.

```bash
$ sh colors                                        (0)
-e
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

状態番号
 デフォルト状態 00
 強調           01
 下線           04
 点滅           05
 色反転         07
 塗りつぶし     08 (塗りつぶし     08)

色番号
 黒               30   40   31;40   32;00;40
 赤               31   41   32;41   33;01;41
 緑               32   42   33;42   34;04;42
 黄(または茶)     33   43   34;43   35;05;43
 青               34   44   35;44   36;07;44
 紫               35   45   36;45   37;00;45
 シアン           36   46   37;46   30;01;46
 白(またはグレー) 37   47   30;47   31;04;47
```



### get_ssid.sh

- show said connected.

```bash
$ get_ssid
BxxxxxJ-3xxx8-G
```



### holiday

- show japanese holiday

```bash
$ holiday
20190101 元日
20190114 成人の日
20190211 建国記念の日
20190321 春分の日
20190429 昭和の日
20190430 祝日
20190501 天皇の即位の日
20190502 祝日
20190503 憲法記念日
20190504 みどりの日
20190505 こどもの日
20190506 こどもの日_振替休日
20190715 海の日
20190811 山の日
20190812 山の日_振替休日
20190916 敬老の日
20190923 秋分の日
20191014 体育の日
20191022 即位礼正殿の儀の行われる日
20191103 文化の日
20191104 文化の日_振替休日
20191123 勤労感謝の日
20200101 元日
20200113 成人の日
20200211 建国記念の日
20200223 天皇誕生日
20200224 天皇誕生日_振替休日
20200320 春分の日
20200429 昭和の日
20200503 憲法記念日
20200504 みどりの日
20200505 こどもの日
20200506 憲法記念日_振替休日
20200723 海の日
20200724 体育の日
20200810 山の日
20200921 敬老の日
20200922 秋分の日
20201103 文化の日
20201123 勤労感謝の日
20210101 元日
20210111 成人の日
20210211 建国記念の日
20210223 天皇誕生日
20210320 春分の日
20210429 昭和の日
20210503 憲法記念日
20210504 みどりの日
20210505 こどもの日
20210719 海の日
20210811 山の日
20210920 敬老の日
20210923 秋分の日
20211011 体育の日
20211103 文化の日
20211123 勤労感謝の日
```



### wareki

- show warei and century

```bash
$ wareki 2020
令和2年  2020
```



### worldtime

- show world time

```bash
$ worldtime
Sydney:         Tue Oct 13 20:39:05 AEDT 2020
Tokyo:          Tue Oct 13 18:39:05 JST 2020
Hong Kong:      Tue Oct 13 17:39:05 HKT 2020
Shanghai:       Tue Oct 13 17:39:05 CST 2020
London:         Tue Oct 13 10:39:05 BST 2020
New York:       Tue Oct 13 05:39:05 EDT 2020
Los Angeles:    Tue Oct 13 02:39:05 PDT 2020
```

