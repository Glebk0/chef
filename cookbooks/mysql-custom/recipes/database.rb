#
# Cookbook:: mysql-custom
# Recipe:: database
#
# Copyright:: 2018, The Authors, All Rights Reserved.

passwords = data_bag_item('passwords','mysql')

mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  initial_root_password passwords['root_password']
  bind_address '0.0.0.0'
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_connection_info = {
    host: '127.0.0.1',
    username: 'root',
    password: passwords['root_password']
}

template '/tmp/db.sql' do
  source 'db.sql.erb'
  variables :passwords => passwords
end

execute 'mysql_configuration' do
  command 'mysql -h 127.0.0.1 -uroot -pfakerootpassword -s < /tmp/db.sql'
  action :nothing
end

service 'mysql-default' do
  action :nothing
end


mysql_database node['mysql-custom']['database']['dbname'] do
  connection mysql_connection_info
  action :create
  notifies :run, 'execute[mysql_configuration]', :immediately
  notifies :restart, 'service[mysql-default]', :immediately
end





