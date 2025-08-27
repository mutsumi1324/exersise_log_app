source "https://rubygems.org"

ruby "3.4.5" # 使うRubyに合わせて

gem "rails", "~> 8.0.2", ">= 8.0.2.1"
gem "puma", ">= 5.0"           # Webサーバ
gem "pg"                        # 本番は Postgres を推奨
gem "propshaft"                 # Rails 8 の標準アセット
gem "importmap-rails"           # JS管理を最小構成で
gem "turbo-rails"               # 画面遷移高速化
gem "stimulus-rails"            # ちょいJS
gem "bootsnap", require: false  # requireをキャッシュ化
#（bootsnapｼ自体は自動でrequireせずconfigでいいタイミングでrequire）

# 画像使うなら後で有効化
# gem "image_processing", "~> 1.2"

group :development do
  gem "web-console"             # 例外ページからconsole
end

group :development, :test do
  gem "debug", require: "debug/prelude"
end