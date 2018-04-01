# AtCoder に登録したら解くべき精選過去問 10 問を Python3 で解いてみたが二番煎じ
## 気づいてしまったこと

既に上げられていたので、出遅れた。

http://delta114514.hatenablog.jp/entry/2018/03/15/014555



## まえがき

ただPythonで解いたものをPythonの機能的に解説しているだけです。
基本的にAtCoderで提出する際はPythonではなく、PyPyで提出してください。基本文法は変わりません。（PyPyは実行形式に変換するため、若干高速になります、4倍位。これによりPyPyなら通る問題も出てきます。）

ボクの記事をいいねしなくていいので、元の記事をいいね・ストックしてあげてください。

https://qiita.com/drken/items/fd4e5e3630d0f5859067

また、基本的なロジックは元記事の解説以上に書くことがありませんので（素晴らしすぎる）、Pythonの機能ではどうかけて、どう短く書けるかを紹介することにフォーカスを当てています。

もし不安なことがあればリファレンスを参照して調べましょう。
Pythonは組み込みのライブラリが充実しており、便利なクラス、関数が見つかる場合も多々あります。
しかも日本語です。（最高ですね）

https://docs.python.jp/3/index.html

問題群はこちらです。 https://beta.atcoder.jp/contests/abs/tasks

## 対象

Pythonで競技プログラミングをしてみたい方、実際にPythonを書いてみたい方。

## 入力関数
### 諸注意
2系の場合はこの記事が参考になる。

https://qiita.com/lethe2211/items/6cbade2bc547649bc040

3系は **input()** からすでに違うので、注意が必要。

3系でのinput()はstr型で取得できる。

### `N`(数値)を受け取る

```python
n = int(input())
```

### `S`(文字列)を受け取る

```python
s = input()
```

### `A B C`(数値)を受け取る
mapを使う方が短いので、そちらを覚えておけば問題ないはず。

でも、内包表記はPythonで重要な概念になるので、2つ目の書き方は抑えてください。

```python
# mapを使う場合
a, b, c = map(int, input().split())
# 内包表記で受け取って変換する場合
a, b, c = [int(i) for i in input().split()]
```

### `S1 S2 S3`(文字列)を受け取る
```python
s1, s2, s3 = input().split()
```

### 縦に並ぶ数値を受け取る
下記のパターンの話

```python
N
A1
A2
A3
```

listを結合するappendを使っても良いが、 **内容表記を使うほうが高速** である
```python
alist = [int(input()) for _ in range(int(input()))]
```

## 問題と解説
### はじめてのあっとこーだー（Welcome to AtCoder）

公式の回答例がありますので、省略します。

### 第 1 問: ABC 086 A - Product (100 点)

愚直に掛け算の結果を利用して、2の剰余を求めて分岐します。

```python
a,b = map(int, input().split())
if (a * b) % 2 == 0:
  print('Even')
else:
  print('Odd')
```

### 第 2 問: ABC 081 A - Placing Marbles (100 点)

文字列に含まれている文字数をカウントするメソッドが用意されている（ `count(c)` です、`c` は文字列 ）のでそれを活用しましょう。

```python
s = input()
print(s.count('1'))
```

### 第 3 問: ABC 081 B - Shift Only (200 点)

2進数に変換した結果の1の数を数えるという方法も存在していますが、愚直に数え上げます。

なお、if文の判定ですが、全てが偶数だった場合は空になり、空のリストは `False` として判定されます。
逆に1つでも要素が存在するリストの場合は `True` として判定されます。

これを利用して簡潔にコードを記述します。

```python
n = int(input())
nums = [int(i) for i in input().split()]
ans = 0
while True:
    if [i for i in nums if i % 2 == 1]:
        break
    nums = [i//2 for i in nums]
    ans += 1
print(ans)
```

### 第 4 問: ABC 087 B - Coins (200 点)

愚直に多重ループを回します。 

pythonのrangeメソッドは下記のような動作をします。渡す引数は当然全て整数型です。

- 引数1つ `range(n)` の場合、 **0からn未満までの範囲を対象とした1飛びのrangeオブジェクト** となる
- 引数2つ `range(a, b)` の場合、 **aからb未満までの範囲を対象とした1飛びのrangeオブジェクト** となる
- 引数3つ `range(a, b, r)` の場合、 **aからb未満までの範囲を対象としたr飛びのrangeオブジェクト** となる

PythonのForループはイテレータブルなものを順次取り出していくため、常に `for each` ループになっていると考えても良さそうです。（あくまで私の理解で、厳密ではないと思われる）

注目すべきは **n未満** という点で、最大値がnになりうる問題の場合、 `n+1` としてループを回す必要があります。

```python
a, b, c, x = [int(input()) for _ in range(4)]
ans = 0
for i in range(a+1):
    for j in range(b+1):
        for k in range(c+1):
            if 500 * i + 100 * j + 50 * k == x:
                ans += 1
print(ans)
```

### 第 5 問: ABC 083 B - Some Sums (200 点)

各桁の和については、下記のように求められます。

`sum([int(c) for c in str(数値)])`

これは何をしているかと言うと

− 数値を文字列に変換する `str(数値)`
− 文字列はイテレータブルなので、それを使って各桁を数値に変換したリストを作る
- sum関数で合計値を求める

というちょっと複雑な処理をしています。

また、Pythonでは `A以上B以下のXの場合` という条件を `if A <= X <= B:` のように書くことが出来ます。自然でいいですね。 

```python
n, a, b = map(int, input().split())
ans = 0
for i in range(1, n+1):
    if a <= sum([int(c) for c in str(i)]) <= b:
        ans += i
print(ans)
```

### 第 6 問: ABC 088 B - Card Game for Two (200 点)

Pythonのリストは `sort()` メソッドでソートが可能です。このメソッドはデフォルトでは昇順になっています。

今、ゲームルールから大きいものから順に（降順）に並んでいてほしいため、キーワード付き引数として `reverse=True` を渡すと簡単に昇順にできます。

Pythonのリストは非常に柔軟に作られており、簡単にそのリストの部分を取り出すことが出来ます。

`nums[a:b:x]` のように引数（？）を渡すことが可能です。 `a:b` は **index Aからindex Bの1つ前まで** を取り出します。（rangeの例と一緒）
`a` と `b` はそれぞれ省略可能で、 `a` を省略した場合はリストの最初から、 `b` を省略した場合はリストの最後までを対象とします。
最後の `:x` はいくつ飛びにするかをを表現します。基本省略されることが多いです。

が、今回はターン毎に取得してほしいのでこの機能が大活躍します。ステップを2つづつにし、始点を0と1でそれぞれリストを作り出し、合計値の差分を取れば簡単に書けてしまいます。

```python
n = int(input())
nums = [int(i) for i in input().split()]
nums.sort(reverse=True)
print(sum(nums[::2]) - sum(nums[1::2]))
```


### 第 7 問: ABC 085 B - Kagami Mochi (200 点)
#### 解法1 set を使う

`set` は集合を扱うためのクラスになりますが、listをsetに渡してやると重複を取り除くことができます。
setに変換したものをイテレータブルなもののサイズを返すlen関数を使えば、終わりです。

```python
nums = [int(input()) for _ in range(int(input()))]
print(len(set(nums)))
```

実はワンライナーになりますね。

```python
print(len(set([int(input()) for _ in range(int(input()))])))
```

#### 解法2 dict を使う

dict型はkeyとvalueの値を保持します。dictionaryやmapという名称で他の言語は取り扱われている場合もあります。

dictに登録されている数値を記録させておいて、その長さを図るという技が使えそうですね。

```python
nums = [int(input()) for _ in range(int(input()))]
num_dict = dict()
for i in nums:
    num_dict[i] = True
print(len(num_dict.keys()))
```

### 第 8 問: ABC 085 C - Otoshidama (300 点)

愚直に計算します。下3桁は利用しないので切り落としています。

途中でプログラムを終了する場合は、 `exit(0)` 関数を呼びます。

Pythonでprint文に対し、カンマ区切りで変数を渡すと、空白区切りで出力されます。

```python
n, yen = map(int, input().split())
yen //= 1000

for noguchi in range(n + 1):
    for higuchi in range(n + 1 - noguchi):
        yukichi = n - noguchi - higuchi
        if noguchi + higuchi * 5 + yukichi * 10 == yen:
            print(yukichi, higuchi, noguchi)
            exit(0)
print("-1 -1 -1")
```

## 第 9 問: ABC 049 C - Daydream (300 点)

この問題では少しズルをしましょう。実は正規表現でガリガリ置き換えても正解することが出来ます。
Pythonの場合、正規表現ライブラリをimportする必要があり、 `import re` を最初に書く必要があります。
`re.sub(pattern, word, line)` はlineのうち、patternに一致する部分をwordに変換します。

また、Pythonには三項演算子が存在しませんが、後置の if-else で代用が可能です。

```python
import re

s = input()
s = re.sub('eraser', '', s)
s = re.sub('erase', '', s)
s = re.sub('dreamer', '', s)
s = re.sub('dream', '', s)
print('YES' if len(s) == 0 else 'NO')
```

## 第 10 問: ABC 086 C - Traveling (300 点)

基本的には元記事の開設の通り、距離に着目して移動可能かどうかを判定します。
行けるかどうかと、その辺をウロウロしてて入れるかの2つを判定すればいいですね。

お気づきの方もいるかもしれませんが、Pythonは複数の変数に同時に代入が出来ます。

`t, x, y, = next_t, next_x, next_y` のように出来るのは素敵ですね。

```python
t, x, y = 0, 0, 0
for i in range(int(input())):
    next_t, next_x, next_y = map(int, input().split())
    diff = abs(x - next_x) + abs(y - next_y)
    if diff > (next_t - t) or (diff - (next_t - t)) % 2 == 1:
        print("No")
        exit(0)
    t, x, y, = next_t, next_x, next_y
print("Yes")
```

# おわりに

意外と他の言語ばかり触っていると気づかないようなことに気づけたら幸いです。

現在、競技プログラミングでPythonを書いたことから自分自身の転職にも繋がったので、ぜひ良かったらPythonを僕と一緒に書きましょう。（なるべく解法ははてなブログの方へあげます）
