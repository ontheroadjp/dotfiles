
## 環境

Mac OSX Yosemite & Sublime Text 3

# Sublime Text 3 の日本語関連の問題点

* Sublime Text 3 では日本語関連に若干の問題あり
* 具体的には、
	1. 日本語変換の確定時に文字が消える
	2. 変換候補を TAB で選択できない
	3. F7 でカタカナ変換できない

* 日本語が消える問題は通常のファイル編集時は問題無し。検索時（Cmd + f）やプラグインを使った操作時に発生するっぽい。

## 回避方法

* いずれの問題もデフォルトのキーバインディングを変更することで”ある程度”回避できる。
* ただし「日本語変換の確定時に文字が消える」問題についてはあくまで、検索時（Cmd + f）のみであり、複数ファイル検索（Cmd + Shift + f）や
DocBlockr 、FuzzyFileNav などのプラグインではやっぱり文字消える。（場合によっては個別対策あり）
* そんなことめんどくていちいちやってらんねーな場合は、文字が消えたらアンドゥ（Cmd + z）で消えた文字復活できる。

### デフォルトのキーバインディングの変更方法

* デフォルトの設定ファイル（Sublime Text > Preferences > Settings - Default）は編集できないので、自分でデフォルトの設定ファイルつくる

### デフォルトの設定ファイルの作り方

1. 
	```
	~/Library/Application Support/Sublime Text 3/Packages/
	```

	の中に「Default (OSX).sublime-keymap」を作成する。自分はわかりやすいように Default フォルダを作ってその中に入れた。こんな感じ。

	```
	~/Library/Application Support/Sublime Text 3/Packages/Default/Default (OSX).sublime-keymap
	```

2. 作成した「Default (OSX).sublime-keymap」に、オリジナルのデフォルトの設定ファイルの内容を全コピー
すれば、作成したファイルがデフォルトの設定ファイルとして使われるようになる。


### 作成したデフォルト設定ファイルの編集

#### (1)日本語変換の確定時に文字が消える（検索時のみ）の対策

* 作成したデフォルト設定ファイルの中の、以下の 3箇所をコメントアウトして無効化する。
* 副作用は特に無し。「次の検索」は Cmd + g で（むしろ Cmd + g が Mac 標準）。

```
//	{ "keys": ["enter"], "command": "find_next", "context":
//		[{"key": "panel", "operand": "find"}, {"key": "panel_has_focus"}]
//	},
```

```
//	{ "keys": ["enter"], "command": "find_next", "context":
//		[{"key": "panel", "operand": "replace"}, {"key": "panel_has_focus"}]
//	},
```

```
//	{ "keys": ["enter"], "command": "hide_panel", "context":
//		[{"key": "panel", "operand": "incremental_find"}, {"key": "panel_has_focus"}]
//	},
```


#### (2) 変換候補を TAB で選択できないの対策

* 作成したデフォルト設定ファイルの中の、以下をコメントアウトして無効化する。  
* 副作用として TAB でコード補完もできなくなるのは痛い。  
(Ctrl＋Space でもコード補完出来るけど・・)
* 変換候補は上下矢印で選べるので、対策せずにそのままの方が良いかも。


```
// { "keys": ["tab"], "command": "insert_best_completion", "args": {"default": "\t", "exact": true} },
// { "keys": ["tab"], "command": "insert_best_completion", "args": {"default": "\t", "exact": false},
//  "context":
//  [
//    { "key": "setting.tab_completion", "operator": "equal", "operand": true }
//  ]
// },
```

#### (3) F7 でカタカナ変換ができないの対策

* 作成したデフォルト設定ファイルの中の、以下をコメントアウトして無効化する。
* 副作用は特に無し。 Build は Cmd + b で。

```
//	{ "keys": ["f7"], "command": "build" },
```

## その他

* （試してないけど）参考になりそうなサイト

日本語が消える問題のパッケージ対策（DocBlockr や SmartMarkdown）  
<a href="http://qiita.com/uskiita/items/e0a39d72445db7c78e21">MacのSublimeText3で日本語が消えるバグを回避する - Qiita</a>

日本語が消える問題のパッケージ対策（Emmet）  
<a href="http://qiita.com/akey/items/150dfa27d50a94ffb6fd">SublimeText2 - Sublime Text 2: 日本語変換確定後に文字が消えるのを防ぐ for Emmet - Qiita</a>

