# 環境構築

## 背景

cad-queryはcondaを使ったインストールが主にサポートされているため、conda環境を作る必要がある。

そのため、Docker内で環境を作成した。

現環境がWSLなため、WSL+Dockerを用いた環境構築も一緒に行う

## WSL+Docker+VSCode

VSCodeにDev Containers拡張機能は入っていたため、以下の流れでDocker コンテナ内の環境を使用できる。

1. ワークスペース直下に.devcontainerディレクトリを作成し、.devcontainer/devcontainer.jsonを作成
2. VSCode でフォルダを「Open」
   1. Ctrl+Shft+P
   2. Dev Containers: Open Folder in Fontainer...をクリック
   3. ワークスペースのディレクトリ（.devcontainerがあるディレクトリ）を指定
   4. VSCode が .devcontainer/devcontainer.json を読み込み、Docker イメージをビルド→コンテナ起動してくれる

以下、はまったポイント

- https://zenn.dev/rhene/articles/docker-on-wsl2-for-vscode
  - WSL内のDockerを使用するという、Dev Containersの設定が必要そう
- イメージの作成がもしかしたら必要？
  - イメージ作成前だとエラーになった
  - もしかしたらビルド時間がかかりすぎたのが原因かもしれないが、わからない
- イメージの更新が反映されない場合がある
  - VSCodeを閉じてもコンテナが動き続けているかもしれない
  - その場合、コンテナを削除すれば新しいイメージを参照する
    - vscから始まるイメージが作成されているので、それも削除する必要があるかもしれない

## GUI

次にqd-editorをコンテナ内で実行してそれをWindows側で確認するために、GUIまわりの設定を行った。

以前はXサーバーなどを用いていたが、WSLgを用いることで、WSLからWindows側へ簡単にGUIを表示できるらしい。

https://qiita.com/y-tsutsu/items/6bc65c0ce4d20a82a417

以前にXサーバーを用いたGUI表示をしていた場合、DISPLAY環境変数が.bashrcなどで書き換えられている可能性があるので、それを戻す必要がある。

WSL内のコンテナから、Windows側に、WSLgを用いてGUIを表示させることについては以下を参考にした。

https://zenn.dev/holliy/articles/51012ef059aa9f
