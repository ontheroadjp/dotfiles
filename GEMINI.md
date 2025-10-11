## 1. プロジェクト概要

- このプロジェクトは、OSや各種アプリの設定ファイルなどを管理する dotfiles プロジェクト
- さまざまな shell script や python script などのユーティリティを含む
- いくつかの sub repository を含む場合もあり
- **リポジトリURL:** https://github.com/ontheroadjp/dotfiles
- コードベースはGitHubで管理し、すべての開発タスクはGitHubのIssueで管理します。

## 2. GitHub操作

- **すべてのGitHub操作（Issue作成、ブランチ作成、プルリクエスト作成など）は、MCP（Gemini）を通じて行います。** 開発者が直接Web UIやGitコマンドで操作することは原則として禁止します。これにより、開発プロセスの一貫性と自動化を担保します。

## 3. 開発ワークフロー

- 当プロジェクトの開発は、すべてGitHub Issueを起点として進行します。**プロジェクトの初期セットアップや構成変更など、コード変更を伴ういかなる作業も、必ずIssueを作成してから開始してください。**これにより、タスクの明確化、進捗の可視化、そして成果物のトレーサビリティを確保します。

### Step 1: Issueの作成

- すべての開発作業（機能追加、バグ修正、リファクタリング等）は、まずGitHub Issueを作成することから始めます。

- **目的:** 開発タスクの要件、背景、ゴールを明確に定義します。
- **記載事項:**
    - **Title:** タスク内容を簡潔に表現してください。(例: `.config/ の整理`)
    - **Body:**
        - **背景 (Background):** なぜこのIssueが必要なのか、どのような課題を解決するのかを記述します。
        - **要件 (Requirements):** 実装すべき機能の仕様を箇条書きで具体的に記述します。
        - **前提事項 (Prerequisites):** このタスクに着手するための条件や、依存する他のIssueがあれば記述します。
        - **テストケース (Test Cases):** 実装が完了したことを確認するための具体的なテストシナリオを記述します。成功ケースと失敗ケースの両方を想定してください。

### Step 2: ブランチの作成

Issueを作成後、そのIssueに対応する作業ブランチを作成します。

- **ブランチ命名規則:** `feature/<issue番号>_<issue title>`
- **例:** Issue番号が`#10`でissueタイトルが`hogehoge`の場合、ブランチ名は `feature/#10_hogehoge` となります。

### Step 3: 実装とテスト

作成したブランチ上で、Issueに定義された要件に基づき実装を行います。

### Step 4: プルリクエストの作成

実装とテストが完了したら、開発用の`dev`ブランチに対してプルリクエストを作成します。

- **タイトル:** `[#<issue番号>] <Issueのタイトル>` の形式で記述します。
- **本文:**
    - `Closes #<issue番号>` を記載し、マージ時に自動でIssueが閉じるように設定します。
    - 実装内容の概要や、レビューしてほしい点を記述します。

### Step 5: コードレビューとマージ

- 作成されたプルリクエストは、チームメンバーによるコードレビューを受けます。
- レビューでの指摘事項を修正し、承認（Approve）されたら、プルリクエストをマージします。

## 4. コミットメッセージの規約

- コミットメッセージは [Conventional Commits](https://www.conventionalcommits.org/) の規約に従い全て英語で表記します

## Note

- 指示されたこと以外は絶対に実行しません
- README は、必ず英語版（README.md）と日本語版（README.ja.md）を作成します
- Javascript は [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html) に準拠します
- Git コミットメッセージは [Conventional Commits](https://www.conventionalcommits.org/) の規約に従い全て英語で表記します

