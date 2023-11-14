FROM ruby:3

# 作業ディレクトリの設定
WORKDIR /app

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# その他のファイルをコピー
COPY . /app/

# デフォルトでSinatraを実行
CMD ["ruby", "server.rb"]
