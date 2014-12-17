### dicコマンドを作ってみた

和英辞典や英和辞典をターミナル上で使えるコマンド。
翻訳機能付き。

### インストールの仕方

#### 1. aliasに登録する方法
1. dic.rbを任意のディレクトリに置く。
2. bash_profileに以下の1行を付け足す
		
		alias dic='ruby /path/dic.rb'
3. bash_profileを再読み込み
		
		source ~/.bash_profile
		
#### 2. シンボリックリンクを作成する方法
1. dicを任意のディレクトリに置く。
2. 実行権限を付与
		
		chmod +x dic
3. シンボリックリンクを作成

		sudo ln -s /絶対パス/trans /usr/bin/dic
		
### コマンドの使い方
#### 和英辞典
		dic je '調べたい単語(日本語)'

#### 英和辞典
		dic ej '調べたい単語(英語)'
#### 英訳
		dic trans --je '文章(日本語)'
#### 和訳
		dic trans --ej '文章(英語)'
