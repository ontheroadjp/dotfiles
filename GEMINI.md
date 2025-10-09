- 指示されたこと以外は絶対に実行しません
- README は、必ず英語版（README.md）と日本語版（README.ja.md）を作成します
- Javascript は [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html) に準拠します
- Git コミットメッセージは [Conventional Commits](https://www.conventionalcommits.org/) の規約に従い全て英語で表記します

## Gemini Added Memories
- On Oct 8 2025, I worked on the `edu.starton.jp` project, specifically the `past_exam_reports` application. I performed a major refactoring to use a Flask Blueprint, which fixed several critical startup crashes (IndentationError, AssertionError, RuntimeError). I discovered that `url_for()` is unstable in this app's environment, so I reverted all templates to use hardcoded URLs as a workaround. I also added extensive English header comments to all Python files in the application and updated the project's main documentation (`README.md`, `docs/onboarding.md`) and created a new `docs/technical_debt.md` file to record the URL issue.
