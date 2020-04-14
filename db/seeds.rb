# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 都道府県と市区町村をCSVファイルからインポートしてDBへ投入-------------------------------------------
unless Prefecture.exists? && City.exists?
  require "csv"

  CSV.foreach("db/KEN_ALL.CSV") do |row|
    pref_name = row[0]
    city_name = row[1]
    pref = Prefecture.find_or_create_by(:name => pref_name)
    City.find_or_create_by(:name => city_name, prefecture_id: pref.id)
  end
end

# ジャンルの初期データを投入---------------------------------------------------------------------
[
  ['ロック'],
  ['パンク'],
  ['ラウドロック'],
  ['メタル'],
  ['ヘヴィメタル'],
  ['デスメタル'],
  ['ハードロック'],
  ['ハードコア'],
  ['エモ'],
  ['スクリーモ'],
  ['メロコア'],
  ['ポップ'],
  ['ジャズ'],
  ['ファンク'],
  ['レゲエ'],
  ['ファンク'],
  ['ソウル'],
  ['スカ'],
  ['R&B'],
  ['EDM'],
  ['民謡'],
  ['ユーロビート'],
  ['インスト'],
  ['アニソン'],
  ['ボカロ'],
  ['その他']
].each do |a, b|
  Genre.create!(
    name: a
  )
end

# パートの初期データを投入---------------------------------------------------------------------
[
  ['ボーカル'],
  ['コーラス'],
  ['ギター'],
  ['ベース'],
  ['ドラム'],
  ['キーボード'],
  ['ピアノ'],
  ['シンセサイザー'],
  ['DJ'],
  ['アレンジャー'],
  ['プロデューサー'],
  ['バイオリン'],
  ['トランペット'],
  ['オルガン'],
  ['フルート'],
  ['シンバル'],
  ['ティンパニー'],
  ['木琴'],
  ['三味線'],
  ['尺八'],
  ['その他']
].each do |a, b|
  Part.create!(
    name: a
  )
end


# 管理者の初期データを投入----------------------------------------------------------------------------------------------
Admin.create!(
   email: ENV["ADMIN_MAIL"],
   password: ENV["ADMIN_PASS"]
)


# メンバーの初期データを投入---------------------------------------------------------------------------------------------
[
  ['guest@example.com', 'example', 'ゲストユーザー', 'male', Date.new(2020, 3, 31),
    "私はゲストユーザーです！\r\nゲストユーザーでは編集機能と退会機能が使用できません！\r\nそれ以外の機能は使用可能です！\r\n
    ごゆっくりとお楽しみください！",
    'https://www.youtube.com/watch?v=lDK9QqIzhwk',
    './app/assets/images/no_image.jpg', DateTime.now],

  ['a@a', 'aaaaaa', '森本ちあき', 'female', Date.new(1992, 1, 21),
    "ワンオクロックのコピーバンドを組みたいです！\r\n担当パートはギターを予定しています！\r\n普段は会社員として働いています！\r\n
    宜しくお願いいたします！",
    'https://www.youtube.com/watch?v=z2ed0Tazw0E',
    './app/assets/images/1.jpg', DateTime.now],

  ['b@b', 'bbbbbb', 'はるか', 'female', Date.new(1989, 11, 4),
    "OMIYAってバンドで、ボーカルギターとリーダー担当してます(o^∀^o)\r\nまだ２のアマチュアですが、オリジナルで頑張ってます(o^∀^o)\r\n
    私個人で好きなアーティストゎ、\r\nGO!GO!7188、B'z、L'Arc～en～Ciel、SWEEPERS、ホルモン、ｽﾊﾟﾙﾀﾛｰｶﾙｽ、ﾘﾝｷﾝ、アギレラ...など\r\n
    私等のバンドゎ、スタジオでもライヴでも、笑ぃありの楽しぃバンドです(o^∀^o)\r\n
    見てる人も、バンドも、ゃっぱり楽しくなくちゃΝё(≧∇≦)\r\nただ...ライヴの予定がぁるのにドラムがぉらんのですp('⌒｀q)\r\n
    ま、そんな感じで仲良くしてください(≧∇≦)",
    'https://www.youtube.com/watch?v=tKZbHjy9GWM',
    './app/assets/images/2.jpg', DateTime.now],

  ['c@c', 'cccccc', 'Chester', 'female', Date.new(1990, 2, 2),
    "オリジナル曲を中心に、女性ヴォーカル ＋ ピアノ＆コーラス ２名編成のユニットで、月に１～２回ライヴ出演をしています。\r\n活動場所は、都内・川崎・横浜が中心です。\r\nオリジナル曲は、小中学生が歌えるように、明るく前向きな歌が多いです。\r\n今後、全国の子どもたちに歌ってもらえるよう、ネットで楽曲配信を予定しています。\r\nまた、アニソンや子どもの向け歌のカヴァーにも挑戦したいです。\r\nそのために、明るい歌声の女性ヴォーカルを募集しています。\r\n上記のような活動に少しでも興味がある方は、ぜひメッセージを送ってください。\r\nどうぞ、よろしくお願いします。",
    'https://www.youtube.com/watch?v=bswkClwZxeA',
    './app/assets/images/3.jpg', DateTime.now],

  ['d@d', 'dddddd', 'ジョン・レノン', 'male', Date.new(1940, 10, 9),
    "はじめまして！\r\n今日という日までギターの練習に励み切磋琢磨してきました！\r\n夢は武道館でライブする事です！\r\nやる気があり、本気の人だけ宜しくお願いします！",
    'https://www.youtube.com/watch?v=Fna56a_r41s',
    './app/assets/images/4.jpg', DateTime.now],

  ['e@e', 'eeeeee', 'ZAX', 'male', Date.new(1981, 7, 14),
    "HR/HM、洋楽・邦楽のカバー（コピー）～歌謡曲をメタル系にアレンジしたり、パフォーマンスも兼ねたライヴ中心に活動してます。\r\n
    結成４ヶ月、２０～４４歳と年齢層も幅広いですが仲良くやってます。\r\n
    ライヴも３回やり、なかなか好評です。\r\n正ドラマーがいませんので、ツインペの正ドラマーさん募集中です。",
    'https://www.youtube.com/watch?v=jRGrNDV2mKc',
    './app/assets/images/5.jpg', DateTime.now],

  ['f@f', 'ffffff', 'taka', 'male', Date.new(1995, 10, 7),
    "ロックの根底に潜むもの、それは「衝動」である。\r\n走ったっていい、音を飛ばしたって構わない。\r\n
    そんな小さなものを飲み込む力がロックにはある。\r\nそんな考えを持っている人とバンドを組みたい。",
    'https://www.youtube.com/watch?v=vyUMYYc8lxU',
    './app/assets/images/6.jpg', DateTime.now],

  ['g@g', 'gggggg', 'Spear Rib', 'male', Date.new(1985, 6, 6),
    "はじめまして、見てくれてありがとうございます。\r\nギターやってます。
    アコースティックで歌ってくれる女性ボーカルを募集してます。年齢は問いません。\r\n趣味でもプロ志向でも大歓迎です。
    全曲オリジナルなので、楽しく音楽活動できると思います。\r\n
    歌詞はまだないので、書ける方も大歓迎です。\r\n気になった方はお気軽に連絡下さい。\r\n
    最初は音源を渡しますので、気に入ってもらえたら活動していきたいです。\r\n
    メンバーも増やしていきたいです。\r\n
    プロ志向で自分のレベル、経験値を上げたい方、趣味を増やしたい、楽しく活動したい方、連絡待ってます",
    'https://www.youtube.com/watch?v=3J_7BEHLRTE',
    './app/assets/images/7.jpg', DateTime.now],

  ['h@h', 'hhhhhh', 'Elsa', 'male', Date.new(1991, 4, 23),
    "しがない村でバンドやってます。\r\nただ今ボーカル募集中です。\r\n全員初心者なので、初心者大歓迎です！\r\n
    できればキーボードも来てほしいなぁ、と思ってたりします。\r\nよろしくお願いします。",
    'https://www.youtube.com/watch?v=zJALPNdJsHU',
    './app/assets/images/8.jpg', DateTime.now],

  ['i@i', 'iiiiii', 'Sachiko', 'female', Date.new(1996, 9, 21),
    "今から7年ほど前に地元でライブ活動をしていてドラムやヴォーカル担当していました。\r\n
    夢の途中で挫折をしてしまい今は趣味程度でギターを弾いているぐらいです。\r\n
    ギター、ドラム共に大した腕もないです。\r\n
    でも本メンバーが見つかるまでの間に合わせメンバーで構わないという方がいたら是非、誘って下さい。\r\n
    ヴォーカル、ギター、ベース、ドラム何でも構わないです。\r\n
    使えないと判断したらいつでも切り捨てていいのでよろしくです。\r\n
    ジャンルはやっぱりrock！でも特に好き嫌いはないので気軽にお願いします。",
    'https://www.youtube.com/watch?v=li8oTUdzd9c',
    './app/assets/images/9.jpg', DateTime.now],

  ['j@j', 'jjjjjj', 'Judy', 'female', Date.new(1988, 5, 16),
    "こんにちは！社会人で忙しい人達が集まってバンドしています。\r\n
    今は80′Sの洋楽ヒット曲をみつくろってやっています。\r\n
    簡単な曲をサクサクっと覚えて曲数そろえて活動していきたいところです。\r\n歳は30歳代のメンバーです。",
    'https://www.youtube.com/watch?v=k6EQAOmJrbw',
    './app/assets/images/10.jpg', DateTime.now],

  ['k@k', 'kkkkkk', 'ビリーバー', 'male', Date.new(2000, 2, 20),
    "ギターﾘｽﾄです。耳コピ、アレンジ、作曲できます。\r\nブランクありますが、腕は落ちていないと思います。\r\n
    以前所属していたバンドの音源はあります。\r\nｱﾅﾛｸﾞ人間なので宅録はできません。\r\n
    作曲はボイスレコーダーとリズムマシーンで弾き語りになります。",
    'https://www.youtube.com/watch?v=LYU-8IFcDPw',
    './app/assets/images/11.jpg', DateTime.now],

  ['l@l', 'llllll', '景子', 'female', Date.new(1989, 3, 18),
    "とにかくバンドを組みたいです。\r\nずっと音楽にかかわりたい気持ちがあったのですが、達成できず、今に至ります。\r\n
    でもやはり夢はすてきれず、でもまずなにから始めたら良いかがわからずこのページまでたどり着きました。\r\n
    勉強させていただきます。",
    'https://www.youtube.com/watch?v=rIkgpU1n8Jc',
    './app/assets/images/12.jpg', DateTime.now],

  ['m@m', 'mmmmmm', 'Jonh', 'male', Date.new(1983, 8, 8),
    "初めまして＾＾\r\n担当する楽器は主にベースですが\r\n
    やろうと思えばギターとドラムもできます♪\r\n楽しいバンドを作れたらいいなと思ってます\r\n
    好きなバンドは東京事変とＢＵＭＰ　ＯＦ　ＣＨＩＣＫＥＮです\r\n
    好きなベーシストはやっぱり亀田誠治さんと直井由文さんです\r\n
    短いですがよろしくお願いします。",
    'https://www.youtube.com/watch?v=sbZMLoaAc6g',
    './app/assets/images/13.jpg', DateTime.now],

  ['n@n', 'nnnnnn', 'uncles', 'male', Date.new(2000, 2, 20),
    "当方Ｇ、Ｄｒ＆Ｖｏというちょっと変わったバンドです。\r\n
    バンド暦は20年近いですが、のんびりやってますので、なかなかこれといった進歩はありません。\r\n
    曲は一応オリジナルで何回かレコーディングもやってます。\r\n
    曲はスピッツ系のメロディアス思考かな。\r\n
    こんな僕らでも一緒にベースやってくれる人いませんか？\r\n
    よろしくお願いします。",
    'https://www.youtube.com/watch?v=CwPJOeWKZ7Y',
    './app/assets/images/14.jpg', DateTime.now],

  ['o@o', 'oooooo', 'DeepPurple', 'male', Date.new(1991, 5, 9),
    "ロックが好きです。楽器の生の音そして、音楽を他の人間と共有出来ることに幸せを感じます。\r\n
    ロックと言われている音楽が誕生し５０余年。時代を象徴する音。\r\n
    それを愛する皆さんとその音を奏でてみたいそんな風に思います。\r\n
    演奏は決して上手ではないですが、大好きなロックをやりたい気持でいっぱいです。\r\n
    ここは、田舎ですから思ったような活動は出来ないのかもしれません。\r\n
    でもここで生きていかなければならない人間だってロックしたっていいんじゃないでしょうか。",
    'https://www.youtube.com/watch?v=lq_YHdwbxrg',
    './app/assets/images/15.jpg', DateTime.now]

].each do |a, b, c, d, e, f, g, h, i|
  prefecture = Prefecture.all.sample(1)
  city = City.where(prefecture_id: prefecture[0].id).sample(1)
  member = Member.new(
    email: a,
    password: b,
    name: c,
    gender: d,
    birthday: e,
    address_prefecture: prefecture[0].name,
    address_city: city[0].name,
    introduction: f,
    sound: g,
    profile_image: File.open(h),
    online_at: i
  )
  member.save!(validate: false)
end


# memberに紐づく初期データを投入---------------------------------------------------------------------------
Member.ids.each do |n|
  Genre.all.sample(rand(3..6)).each do |genre|
    genre_member = GenreMember.new(
      member_id: n,
      genre_id: genre.id
    )
    genre_member.save!(validate: false)
  end

  Part.all.sample(rand(3..6)).each do |part|
    part_member = PartMember.new(
      member_id: n,
      part_id: part.id
    )
    part_member.save!(validate: false)
  end

  [
    "ONE OK ROCK", "SiM", "Crossfaith", "coldrain", "マキシマム ザ ホルモン", "",
    "Linkin Park", "Sum 41", "Pay money To my Pain", "Nirvana", "Roach", "",
    "FACT", "LiSA", "Judy And Mary", "HER NAME IN BLOOD", "Fear, and Loathing in Las Vegas", "",
    "Crystal Lake", "ROTTENGRAFFTY", "ベイビーレイズJAPAN", "五五七二三二〇", "PassCode", ""
  ].sample(5).each do |artist_name|
    artist = Artist.new(
      member_id: n,
      name: artist_name
    )
    artist.save!(validate: false)
  end

  [
    "いい天気ですね", "今日は美容室！", "この前のライブ最高だった！", "暑いな〜！", "ホルモンめちゃくちゃ重低音！",
    "明日の朝は決戦だ！", "今日も１日頑張るぞ！", "この前の出来事は。。", "ギター弾きてえなあ！", "ドラムレッスン１日目！",
    "まあまあの出来栄えだった！", "スタジオ練習なう！", "ライブがしたい！", "今日はうまく弾けなかった、、反省", "明日こそは！",
    "このままでいいのかな。。", "三味線格好いい！", "ワンオクのライブ最高！", "え？来週新曲出るの！？", "雪が降っとる！",
    "凄まじい勢いやなこのバンドは！", "テレキャス欲しい。。！", "8ビート叩けるようになった！", "ユーロビート意外と良い！", "あっつ〜〜〜",
    "この曲激しすぎる！", "ヘドバンしたい！モッシュも！", "ワニマかっけ〜！", "このバンドメンバーで本当によかった！", "ギター募集してます！",
    "来週はいよいよライブ！", "もっとベース練習しなければ！", "この前まで弾けなかったパートが弾けるようになった！", "Fコード難しい！", "できた！",
    "レスポール最高！", "ピックアップはやっぱりハムバッカー！", "ストラトも良いよね！", "今日までありがとうございました！", "待ちきれない！",
    "アナ雪いいね！", "ニルヴァーナ is forever!", "ライブってこんなに緊張するのか！", "いきものがかり良き！", "明日CD買いにいこ！",
    "今日も雨か、、", "明日は台風くるらしい！", "まだ終わっていない！", "夢は武道館ライブ！", "絶対に諦めない！",
    "幽霊を見た気がする、、、", "金縛りとは、、、！", "SuM 41最高！", "生きていくのは大変です！", "今日は小春日和ですね！"
  ].sample(25).each do |tweet_body|
    tweet = Tweet.new(
      member_id: n,
      body: tweet_body
    )
    tweet.save!(validate: false)

    [
      "素敵ですね！", "いいですね！", "それはちょっと、、", "いいですね！", "まあまあですね！",
      "そんな時もあります！", "それはいけません！", "すごくいいです！", "え？すごい！", "おおお！",
      "まさか！", "う〜ん、、", "Good!", "怖いですね！", "私も好きです！",
      "すごく素敵です！", "私も好き！", "わかる！", "同意します！", "わあ！",
      "そんなことが！？", "いいね！", "センスいい！", "素敵です！", "何という事でしょう！"
    ].sample(rand(0..5)).each do |tweet_comment_body|
      member_id = rand(1..(Member.all.size))
      tweet_comment = TweetComment.new(
        member_id: member_id,
        tweet_id: tweet.id,
        body: tweet_comment_body
      )
      tweet_comment.save!(validate: false)
      tweet.create_announce_tweet_comment!(Member.find(member_id), tweet_comment.id)
    end
  end

  [
    [
      "パワーメタルバンドのボーカル募集",
      "2012年から活動中のCriminalというメタルバンドです。\r\nボーカルを募集しております。\r\n
      音楽性や活動は、条件欄をご覧ください。\r\n年齢のみあくまで参考基準としています。\r\n
      ANGRAのような構築美を感じさせるパワーメタルを理想としています。\r\n
      初期HELLOWEENの影響もあるので、そうした楽曲も多くあります。\r\n
      今回の募集は、初心者の方は申し訳ありませんが、バンド経験者の募集とさせて頂きます。\r\n
      エドゥ・ファラスキやファビオ・リオーネのようなスタイルか\r\n
      ヨルン・ランデやラッセル・アレンのようなスタイルも好みです。\r\n
      海外のボーカリストのみ上げている通り、英語歌詞です。\r\n
      なお、参考音源のYouTubeチャンネルには、他の音源動画も\r\n
      ございますので、ご視聴下されば幸いです。",
      "https://www.youtube.com/watch?v=DLbHfOhJNR4"
    ],

    [
      "新規デスメタルバンドメンバー募集",
      "はじめまして！新規でデスメタル系のバンドを結成したく現在メンバーを探しています。\r\n
      現在私(Dr)と上手gt,vo,baが在籍しており下手gtを募集してます。\r\n
      ゆくゆくはライブハウスでライブをしたいと考えています。\r\n
      活動拠点や練習場所はメンバーが揃い次第決めます。\r\n
      技術力はもちろんですがそれ以上にデスメタルに理解がありそれらのジャンルが好きな方、\r\n
      そして途中で音信不通になったりせず真摯に音楽と向き合える方を募集しております！\r\n
      同時にコンポーザーの方も募集してます、募集パートに加えコンポーザーも兼ねてる方だと大歓迎です！\r\n
      長くなってしまいましたがまずは気軽にメッセージ頂けると嬉しいです！よろしくお願いします！",
      "https://www.youtube.com/watch?v=IGInsosP0Ac"
    ],

    [
      "HR/HMドラム急募！(初心者OK)",
      "タンクのコピーバンドやってます。初心者OKです。ライブ予定あります。\r\n
      最近までは荻窪のスタジオを利用してました。タンクの曲を知らなくても、音源を聴いて覚えてからでも大丈夫です。\r\n
      「ちょっと叩いてみてもいいかな」と思ったハードロック、ヘヴィメタルが好きなドラマーさん、軽い気持ちでも構いません。\r\n
      楽しくロックしましょう。スタジオの場所は話し合って決めましょう。皆様、よろしくお願いいたします。",
      "https://www.youtube.com/watch?v=zTEYUFgLveY"
    ],

    [
      "ゆるーくできるドラム募集",
      "大阪市内で活動しています\r\n\r\n
      こちら40代でギター2人(男性)ベース1人(女性)です\r\n\r\n
      やっているのは基本的にオリジナルのデスメタルですが他のジャンルもやることがあります\r\n\r\n
      曲作りは基本的にこちらでします\r\n\r\n
      メンバーの状況に合わせて不定期で活動していますのでゆる〜く参加できるドラマを探しています\r\n\r\n
      レベルは初心者ではないですがむちゃくちゃ上手いわけではないです\r\n\r\n
      あまり、こだわりが強くなく合わせてもらえる、仲良くできる人よろしくお願いします",
      "https://www.youtube.com/watch?v=hTWKbfoikeg"
    ],

    [
      "エモ、ニューメタル、ヒップホップのベース募集",
      "エモ、ミクスチャー、ニューメタルをやっています。\r\n
      3年目です。ツアー経験があります。\r\n
      この度ベース脱退につき募集します。\r\n
      条件は以下です。\r\n\r\n

      ・15-26歳の男性である\r\n\r\n

      ・エモ、ポストハードコア、ニューメタルの演奏経験がある。\r\n\r\n

      ・HIPHOPやR&Bに興味がある。\r\n\r\n

      練習は週1から\r\n
      ライブは最低月2回\r\n
      春にツアー予定です。\r\n

      応募お待ちしています。",
      "https://www.youtube.com/watch?v=QO3j9niG1Og"
    ],

    [
      "Djent、ラウド、メタル系、リードギター、ドラム募集",
      "現在新規オリジナルバンドを結成しようとリードギター、ドラムを探しています。\r\n\r\n

      現在Vo.♂22歳\r\n
      7弦Gt♀20歳（初心者）\r\n
      5弦Ba.♂29です。\r\n\r\n

      メタル、ラウド、アニソン、Djentなどダウンチューニングに同期が乗ってくるような重い曲からバラードまで幅広く演奏できたらいいなと思っています。\r\n\r\n

      プロ志向ではありませんのでアマ志向寄りですがYouTubeやSNSを駆使しつつセルフプロデュースでのんびり音源を出してライブをして息を長く活動したいと思っています。\r\n\r\n

      スタジオは平日の夜、土日で場所はメンバーで話し合って決めていきたいと思います。",
      "https://www.youtube.com/watch?v=TkV5709EG5M"
    ],

    [
      "魔属性バンドメンバー募集",
      "初めまして。数ある募集記事の中から当記事をご覧いただき誠にありがとうございます。\r\n
      ドラムをやっているエンリュウと申します。\r\n
      この度悪魔や魔物などといった魔属性をコンセプトにしたバンドを結成するためメンバーを募集しております。\r\n
      まず年齢ですが、20代前半から30代前半とさせていただきます。\r\n
      募集パートはボーカル・ギター(1～2名)・ベース・キーボードです。\r\n
      ボーカルのみ女性を希望させていただきますが、その他のパートは性別不問でございます。\r\n
      練習頻度は月に2～4回を考えております。1回の練習時間は最低2時間を予定しております\r\n
      時間帯は日中を予定しております。\r\n
      曜日に関しましては相談して決めます。練習場所に関しましては新宿等を検討しております。\r\n
      活動の方向性としましてはインディーズ～プロ志向です。\r\n
      ジャンルに関しましてはハードロック・ヘヴィメタルを中心に色々とやっていこうと考えております。\r\n
      楽曲に関しましてはコピーから始めて、次第にオリジナル曲を手掛けていこうと考えております。\r\n
      コピーに関しましてはバンドのコンセプトに影響を与えている聖飢魔IIの楽曲から始めていく予定です。\r\n
      オリジナル曲を作成する際はメンバー全員で作り上げていくのが理想です。\r\n
      参考程度に聖飢魔IIのFIRE AFTER FIREを演奏している動画を貼っておきます。\r\n
      ご応募いただける方がいらっしゃいましたら、年齢・性別・希望パート・参考音源を添えてご連絡下さい。\r\n
      長くなりましたがご覧いただきましてありがとうございました。ご連絡お待ちしております。",
      "https://www.youtube.com/watch?v=lRV2aoQ--94"
    ],

    [
      "鍵盤プレイヤー募集",
      "当方、Vo＆Guitar,Bass,Drum,Lead Guitarの４人編成の社会人バンドです。\r\n
      ライブ経験のある鍵盤さんを年齢、性別問わず募集します。\r\n\r\n

      ジャンルとしては、オーソドックスかつ少し古めの洋楽のロックのカバーで\r\n
      Eric Clapton(Cream), Rolling Stones,The Who,Bryan Adams,Bruce Springsteen,U2,Grand Funk,The Police, The Beatles\r\n
      等、課題曲をメンバーで決め楽しくジャムってます。\r\n\r\n

      オーソドックスかつブルージーなモノを好み、メタル系の音はあまり取り上げません。\r\n\r\n

      いつまでもロッカーでいたい方、ライブで何ともいえない、ワクワク感や心地よさを味わいたい方からのご応募お待ちしております。\r\n\r\n

      練習は月1−2回くらい。（但し、ライブ前には頻度を上げていきますが…）\r\n\r\n

      場所は梅田もしくは心斎橋近辺です。\r\n
      よろしくどうぞ。",
      "https://www.youtube.com/watch?v=vUSzL2leaFM"
    ],

    [
      "メタルバンドです。ベースとドラム募集します。",
      "はじめまして。\r\n
      ボヘミアンラプソディというオルタナティブメタルバンドです。\r\n\r\n

      楽曲については2000年前後の激しい洋楽メタルに最新のメタルを取り入れたようなメロディやリフ重視のバンドです。\r\n
      とにかくシンプルでかっこいいを重要視していて、ジェントやハードコア、デスコアではないのでご注意ください。\r\n\r\n

      今回はベースとドラムが近いうち抜けてしまうので、\r\n
      うちのバンドでベースまたはドラムをやっていただける人を募集します！\r\n
      正規でやりたい、サポートならいい、なんでもオッケーです。\r\n\r\n

      バンドに対し情熱的で絶対売れてやるという意思を持った人だと大歓迎です。\r\n\r\n

      この記事見て気になった人、\r\n
      詳しい話はメッセージにてお願いします。",
      "https://www.youtube.com/watch?v=Npp0vS2q478"
    ],

    [
      "ガールズバンドドラム、キーボード募集（╹◡╹）",
      "今ゴシックケルトというジャンルでガールズバンドを組んでます！\r\n
      ただ今はオリジナル曲ではなくカバー曲をだしていってる感じです\r\n
      ゴシックだったりメタル寄りだったり激しめの曲をメインとしてます(ロゼリア等)\r\n

      メンバーは私ギターボーカル(20代後半)とベース(20代前半)の二人です\r\n
      ドラムがサポートの状態、キーボードも正式なメンバーが足りません\r\n
      またこちら曲を作ったり、楽器のレッスン、Mix.映像の編集ができるプロデュースに近いような全体的にサポートしてくれる方がいます\r\n
      なので月にいくらかかかります\r\n
      ただいきなりでは不安だと思いますので1.2ヶ月くらい体験していただいて継続する場合に応相談する形をとろうかと思ってます\r\n
      楽器はやる気があれば初心者に近い方でも大丈夫です！\r\n
      活動場所は月2でやってます\r\n
      まずはお気軽にご相談下さい！",
      "https://www.youtube.com/watch?v=Lx3Hwij-a94"
    ],

    [
      "アニソン ベース募集 / キーボードもゆるく募集",
      "この度は、バンドのベースとキーボード(ゆるく)を募集します。\r\n
      掛け持ちでも構いませんが、原則月に1-2回は練習があるので急用で予定が合わない場合以外は参加出来る方が良いです。\r\n\r\n

      あと、曲の難易度的に最低スラップは出来る方が嬉しいです！笑\r\n\r\n

      キーボードの方もゆるーく募集しておりますので気になられましたらお声掛け下さい。\r\n\r\n

      当バンドは社会人バンドです。が高校や大学生の方でも大丈夫です。\r\n
      年齢は24が1番上で、あとは23で固まっております。\r\n\r\n

      ジャンルは基本アニソンやボーカロイドを中心に練習しておりますが、リクエストで選曲してるので他ジャンルの場合もあります。\r\n\r\n

      主なスタジオは246三宮west / 246 梅田です。\r\n
      LIVEの頻度は半年に現在半年に1回。\r\n\r\n

      まずはメッセージからより詳しいお話が出来ればなと考えておりますので、お待ちしております。",
      "https://www.youtube.com/watch?v=dc8NJnVD7Nc"
    ],

    [
      "アニソンバンドのキーボードさん募集中！",
      "閲覧ありがとうございます！\r\n
      アニソンに興味ある方は是非目を通してみてください(ノ´▽｀)ノ\r\n\r\n

      ただいま一緒に活動してくれるキーボードさんを募集してます！\r\n\r\n

      現メンバーは\r\n
      30代～のボーカル、ベース、ドラムです。\r\n
      （後ほどギターさんも募集します）\r\n\r\n

      趣味でやってる初心者バンドなのでスタジオ練習が中心になりますが、ライブを目標に一緒に頑張っていける方、\r\n
      ある程度ピアノが弾ける方、お互いアドバイスし合ったりできる方、アニソンが好きな方、音信不通にならない方、\r\n
      他のバンドと掛け持ちをしていない方が望ましいです。\r\n\r\n

      練習頻度→月に2回の土日どちらか。\r\n
      練習場所→御茶ノ水、秋葉原、高田馬場\r\n\r\n

      練習してる曲→Innocent starter、星間飛行、shinedays、\r\n
      君の知らない物語、U＆I、No thank you！、YAHHO！、Don't say lazy、Hazyなど☆\r\n\r\n

      スタジオ練習の帰りにご飯を食べたり、\r\n
      ゆるーく、たのしーくやってます。\r\n
      ガツガツ系よりほんわかしたバンドです（笑）\r\n\r\n

      質問などありましたら気軽にメッセージください(^ ^)！",
      "https://www.youtube.com/watch?v=HS_qFodzXdc"
    ],

    [
      "ジャズ系女性ボーカル募集",
      "ジャズっぽいデュオをしたいと思い、女性ボーカルを探しています。\r\n\r\n

      スタイルとしては、Jポップやオールディーズをジャズやボサノバっぽくアレンジして演奏しつつ、\r\n
      少しずつジャズスタンダードをしたいと思っています。\r\n\r\n

      リハーサルの場所は大阪全域で大丈夫ですが、大阪市内だと嬉しいです。\r\n\r\n

      ライブは、私のジャズの師匠のライブに飛び入りで演奏させてもらったり、ライブバー、カフェ等でしていきたいと思っています。\r\n\r\n

      年齢、スキルは問わないですし、ジャズを全然知らない方でも大歓迎なのですが、今までライブ、バンドをした事がない方、\r\n
      御自身が歌っている音源か動画を持っていない用意できない方、楽器演奏の経験が全くない方は、申し訳ないですがお断りしております。\r\n\r\n

      デモ音源をYouTubeに上げているので、良かったら聴いてみて下さいませ。\r\n\r\n

      興味のある方は御連絡下さい。",
      "https://www.youtube.com/watch?v=T-8ybSLCRF4"
    ],

    [
      "都内けいおん！アニソンバンド",
      "「けいおん!」のコピーバンドの2ndギターを担当してくれる方を募集します！\r\n\r\n

      現メンバーは\r\n
      ボーカル♀\r\n
      ギター♂\r\n
      ベース♂\r\n
      ドラム♀\r\n
      の4人で全員26歳〜29歳\r\n\r\n

      平和な空気感で楽しく、やるべき時は切り替えてしっかりと！\r\n
      という感じで活動しています！\r\n\r\n

      アニソンイベントではこれまで、同期を使用してライブをしておりました！\r\n\r\n

      次のライブでは、新たに2ndギターを追加して、各パートがより盛り上がるような、生のグルーヴ感溢れるライブをしたいと思っています！\r\n\r\n

      土日メインで活動していきますので、土日が安定して休みが取れる方を優先いたします。\r\n
      （いきなり仕事が入ってしまうなどの場合、他のメンバーに迷惑がかかるため）\r\n\r\n

      ちなみに当方はギター担当です。\r\n\r\n

      けいおんが好きな人でギターをやっている方はぜひご一緒しませんか？\r\n\r\n

      けいおん!を楽しみ尽くした後は、別の作品の楽曲をやりたいとも思っています。\r\n\r\n

      応募が複数の場合は、こちらで選定させていただきますのでご了承ください。\r\n\r\n

      また、返信がしばらくない方についても、こちら判断で別の方を優先する場合がありますのでご了承ください。\r\n\r\n

      サポートや掛け持ち、スケジュールが忙しい方は申し訳ありませんが、予定を組みやすい人を優先させていただきます。\r\n\r\n

      楽器初心者の方は、本当に上達したいという意思をもった人に限らせていただきます。\r\n\r\n

      作品愛に溢れた楽しいバンドです！\r\n\r\n

      ぜひ気になった方は、気軽にメッセージください。",
      "https://www.youtube.com/watch?v=KN-ov_YQqmA"
    ],

    [
      "デュオ編成でのピアニスト、ギタリスト募集",
      "ジャズやモータウンが大好き26歳のベーシストです。\r\n
      最近までジャズやファンク、ソウルミュージックをメインとしたオリジナルバンドをやっておりました。\r\n
      この度カフェやレストランでの演奏を始めたいと思いデュオ編成でのメンバーを募集しております。\r\n
      私自身デュオでの演奏は無に等しいですが、ジャズのスタンダードナンバーやモータウンの曲を練りライブをしたいと考えたおります。\r\n
      息が合う方でしたらいくつでもデュオを組みたいと考えてますので少しでも気になる方は連絡頂けたらと思います\r\n。
      また気になる方にはこちらからも連絡させて頂きますので、どうぞよろしくお願い致します。\r\n
      演奏の音源はご希望の方にお送りいたしますのでご連絡頂けたらと思います。",
      "https://www.youtube.com/watch?v=yqqikJ30EwI"
    ]
  ].sample(rand(1..3)).each do |a, b, c|
    article = Article.new(
      member_id: n,
      category: Article.categories.keys.sample(1)[0],
      subject: a,
      body: b,
      day_of_the_week: Article.day_of_the_weeks.keys.sample(1)[0],
      band_intention: Article.band_intentions.keys.sample(1)[0],
      music_intention: Article.music_intentions.keys.sample(1)[0],
      gender: Article.genders.keys.sample(1)[0],
      age_min: rand(15..25),
      age_max: rand(35..55),
      sound: c,
      band_theme: Article.band_themes.keys.sample(1)[0],
      prefecture_id: Prefecture.all.sample(1)[0].id
    )
    article.save!(validate: false)

    Genre.all.sample(rand(1..5)).each do |genre|
      genre_article = GenreArticle.new(
        article_id: article.id,
        genre_id: genre.id
      )
      genre_article.save!(validate: false)
    end

    Part.all.sample(rand(1..5)).each do |part|
      part_article = PartArticle.new(
        article_id: article.id,
        part_id: part.id
      )
      part_article.save!(validate: false)
    end
  end
end


# メンバーに紐づく初期データを投入２
Member.ids.each do |n|
  current_member = Member.find(n)

  Article.all.sample(rand(3..6)).each do |article|
    article_favorite = ArticleFavorite.new(
      article_id: article.id,
      member_id: n
    )
    article_favorite.save!(validate: false)
    article.create_announce_article_favorite!(current_member)
  end

  Tweet.all.sample(rand(25..50)).each do |tweet|
    tweet_favorite = TweetFavorite.new(
      tweet_id: tweet.id,
      member_id: n
    )
    tweet_favorite.save!(validate: false)
    tweet.create_announce_tweet_favorite!(current_member)
  end

  TweetComment.all.sample(rand(15..30)).each do |tweet_comment|
    tweet_comment_favorite = TweetCommentFavorite.new(
      tweet_comment_id: tweet_comment.id,
      member_id: n
    )
    tweet_comment_favorite.save!(validate: false)
    tweet_comment.create_announce_tweet_comment_favorite!(current_member)
  end

  Member.where.not(id: n).sample(rand(0..3)).each do |member|
    current_member.block(member.id)
  end

  Member.where.not(id: n).sample(rand(3..10)).each do |member|
    unless member.blocking?(current_member)
      current_member.follow(member.id)
      member.create_announce_follow!(current_member)
    end
  end

  Member.where.not(id: n).sample((Member.all.size)-5).each do |member|
    current_member.visitor.create!(visited_id: member.id)
  end
end
