# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server ENV['SERVICE_NAME_PRODUCTION_IP'], user: 'takaaki', port: 22, roles: %w{app db web}, primary: true

set :ssh_options, {
  forward_agent: true,
  keys: "#{ENV['SERVICE_NAME_PRODUCTION_SSH_KEY']}"
}