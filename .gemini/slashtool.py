import os
from gemini.slashtool import register_tool, SlashTool

@register_tool(
    name="/read_docs",
    description="プロジェクトのドキュメントとGit履歴を読み込み、開発準備をします。"
)
def read_docs(tool: SlashTool, args: list[str]):
    """
    プロジェクトのドキュメントとGit履歴を読み込み、開発準備をします。
    1. README.md を読み込む
    2. docs/* を読み込む
    3. git log -n 20 --stat を実行する
    4. Geminiに分析させ、不明点があれば質問させる
    5. 問題がなければ "ready to development!" と応答させる
    """
    print("🚀 プロジェクト情報の読み込みを開始します...")

    # 1. README.md の読み込み
    readme_path = 'README.md'
    if os.path.exists(readme_path):
        print(f"📄 {readme_path} を読み込んでいます...")
        tool.context.load_file(readme_path)
    else:
        print(f"⚠️ {readme_path} が見つかりませんでした。")

    # 2. docs/* の読み込み
    docs_path = 'docs'
    if os.path.exists(docs_path) and os.path.isdir(docs_path):
        # docs ディレクトリ内の全ファイルを再帰的に読み込む
        print(f"📂 {docs_path}/ 以下のファイルを再帰的に読み込んでいます...")
        tool.context.load_glob(f'{docs_path}/**/*')
    else:
        print(f"⚠️ {docs_path} ディレクトリが見つかりませんでした。")

    # 3. Git履歴の確認
    print("🌿 Gitの履歴を確認しています (git log -n 20 --stat)...")
    try:
        # コマンドを実行し、その出力をコンテキストに追加します
        stdout, stderr = tool.context.execute_and_add_output(
            ['git', 'log', '-n', '20', '--stat'],
            label="直近20件のGitコミット履歴"
        )
        if stderr:
            print(f"🚨 Gitコマンドの実行中にエラーが発生しました:\n{stderr}")
    except FileNotFoundError:
        print("🚨 gitコマンドが見つかりませんでした。Gitがインストールされているか、パスが通っているか確認してください。")
    except Exception as e:
        print(f"🚨 Git履歴の確認中に予期せぬエラーが発生しました: {e}")

    # 4 & 5. Geminiへの指示
    print("\n🧠 収集した情報をGeminiに送信し、分析を依頼します...")
    prompt = """
    あなたは優秀なソフトウェアエンジニアです。
    提供された以下のコンテキスト情報を分析し、プロジェクトの開発を始めるための準備をしてください。

    - README.md: プロジェクトの概要
    - docs/*: プロジェクトの詳細情報
    - Git履歴: プロジェクトの最近の変更経緯

    あなたのタスクは以下の通りです。
    1. すべての情報を注意深く読み込み、内容を完全に理解してください。
    2. 情報に不明確な点、矛盾点、あるいは開発を始める前に確認すべき重要な事項があれば、それらを具体的な質問として箇条書きでリストアップしてください。
    3. すべての情報を理解し、特に質問事項がない場合は、最終的な応答として「ready to development!」とだけ出力してください。
    """

    # `tool.prompt_for_response` を使って、現在のコンテキストとプロンプトをGeminiに送信します
    response = tool.prompt_for_response(prompt)
    print("\n✅ Geminiからの応答:")
    print(response)
