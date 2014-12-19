### dicコマンドを作ってみた

和英辞典や英和辞典をターミナル上で使えるコマンド。

### インストールの仕方

#### 1. aliasに登録する方法
1. dic.rbを任意のディレクトリに置く。
2. bash_profileに以下の1行を付け足す
		
		alias trans='ruby /path/dic.rb'
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
		
#### 翻訳(英語 => 日本語)
		dic trans --ej 'sentence'
		
#### 翻訳(日本語 => 英語)
		dic trans --je '文章'
		
