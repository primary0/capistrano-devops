namespace :utilities do
  desc "Report Uptimes"
  task :uptime do
    on roles(:all) do |host|
      info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
    end
  end

  desc "Install common pacakges"
  task :common_packages do
    on roles(:app) do |host|
      execute :sudo, "apt-get -y update"
      execute :sudo, "apt-get -y install python-software-properties htop iftop iotop mytop sysstat screen curl subversion git-core rsync"
    end
  end

  desc 'Install Ruby'
  task :install_ruby do
    invoke :'utilities:common_packages'
    on roles(:app) do |host|
      execute :curl, "-Lo- https://gist.github.com/parasquid/5624732/raw/install-ruby-2-ubuntu.sh | bash"
    end
  end

  desc 'Install the Bundler gem (server-wide)'
  task :install_bundler do
    on roles(:app) do |host|
      execute :sudo, 'gem install bundler'
    end
  end
end
