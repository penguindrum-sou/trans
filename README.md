### transコマンドを作ってみた

和英辞典や英和辞典をターミナル上で使えるコマンド。

### インストールの仕方

#### 1. aliasに登録する方法
1. trans.rbを任意のディレクトリに置く。
2. bash_profileに以下の1行を付け足す
		
		alias trans='ruby /path/trans.rb'
3. bash_profileを再読み込み
		
		source ~/.bash_profile
		
#### 2. シンボリックリンクを作成する方法
1. transを任意のディレクトリに置く。
2. 実行権限を付与
		
		chmod +x trans
3. シンボリックリンクを作成

		sudo ln -s /絶対パス/trans /usr/bin/trans
		
### コマンドの使い方
#### 和英辞典
		trans ja '調べたい単語(日本語)'

#### 英和辞典
		trans en '調べたい単語(英語)'
