source "https://rubygems.org"

ruby "3.4.5" # 使うRubyに合わせて

gem "rails", "~> 8.0.3"
gem "puma", ">= 5.0"           # Webサーバ
gem "pg"                        # 本番は Postgres を推奨
gem "propshaft"                 # Rails 8 の標準アセット
gem "importmap-rails"           # JS管理を最小構成で
gem "turbo-rails"               # 画面遷移高速化
gem "stimulus-rails"            # ちょいJS
gem "bootsnap", require: false# requireをキャッシュ化
# （bootsnap自体は自動でrequireせずconfigでいいタイミングでrequire）
gem "bcrypt", "~> 3.1.7"

# 画像使うなら後で有効化
# gem "image_processing", "~> 1.2"

group :development do
  gem "web-console"             # 例外ページからconsole
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rails-omakase", require: false
  gem "ruby-lsp", require: false
end

group :development, :test do
  gem "debug", require: "debug/prelude"
  gem "brakeman", require: false
  gem "rspec-rails", "~> 8.0.0"
  gem "factory_bot_rails"
end
