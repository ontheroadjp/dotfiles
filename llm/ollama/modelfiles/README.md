# Ollama Custom Modelfiles

Ollama のカスタムモデル設定（`Modelfile`）を管理するディレクトリです。
`ollama create` 実行時に設定は Ollama 内部のデータベースへ焼き込まれるため、ビルド後にこのディレクトリ内のファイルを編集しても自動では反映されません。変更時は必ず再ビルド（`ollama create`）を実行してください。

---

## 1. ディレクトリ構成

```text
~/.config/ollama/modelfiles/
├── README.md
└── gpt-oss-fast.Modelfile
```

---

## 2. 基本コマンド一覧

### 新規作成・変更の再適用（上書きビルド）
`Modelfile` を新規作成した場合や、既存の `SYSTEM` / `PARAMETER` を編集した後に変更を反映する場合は、同じモデル名を指定して `ollama create` を実行します（ベースモデルの重みは共有されるため、ディスク容量は重複消費されません）。

```bash
ollama create gpt-oss-fast -f ./gpt-oss-fast.Modelfile
```

* **確認方法:** `ollama list` にモデル名が表示されること、および `ollama show gpt-oss-fast` で変更後のパラメータ・システムプロンプトが反映されていることを確認します。

### 既存モデルから設定を書き戻す（バックアップ・復元）
手元の `Modelfile` を誤って削除した場合や、現在 Ollama に登録されている設定を確認・保存したい場合は `ollama show --modelfile` を使用します。

```bash
ollama show --modelfile gpt-oss-fast > ./gpt-oss-fast.Modelfile
```

* **注意点:** 出力結果の `FROM` 行には `/usr/share/ollama/.ollama/models/blobs/sha256-...` のような内部パスが記載されます。ベースモデル更新時も再利用できるよう、必要に応じて `FROM gpt-oss:20b` のようにモデル名へ書き換えて保管してください。

### 登録済みモデルの一覧確認・削除

```bash
# 一覧表示
ollama list

# 不要になったカスタムモデルの削除（ベースモデルは消えません）
ollama rm gpt-oss-fast
```

---

## 3. カスタムモデル個別メモ

### `gpt-oss-fast`
16GB メモリ・CPU 推論環境向けにコンテキスト長（`num_ctx 4096`）と日本語の簡潔回答用システムプロンプトを組み込んだ `gpt-oss:20b` 派生モデル。

* **Modelfile 内容 (`gpt-oss-fast.Modelfile`):**

```dockerfile
FROM gpt-oss:20b
SYSTEM 必ず日本語で、1〜2文以内で簡潔に答えてください。
PARAMETER num_ctx 4096
```

* **対話実行コマンド（思考プロセス最小化＋速度計測）:**

```bash
ollama run gpt-oss-fast --think=low --verbose
```

* **API 呼び出し時の注意:**
  `--think=low` は CLI オプションのため、`Modelfile` には保存されません。API（`/api/chat` や `/api/generate`）から呼び出す際は、リクエスト JSON に `"think": "low"` を明示的に含めてください。

---

## 4. ベースモデル更新時の再適用フロー

元のベースモデル（`gpt-oss:20b` など）を `ollama pull` で最新版に更新した場合、カスタムモデルは自動では更新されません。以下の順で再ビルドしてください。

```bash
ollama pull gpt-oss:20b
ollama create gpt-oss-fast -f ./gpt-oss-fast.Modelfile
```
