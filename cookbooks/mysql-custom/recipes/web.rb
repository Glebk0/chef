#
# Cookbook:: mysql-custom
# Recipe:: web
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create the doc root directory.
directory node['mysql-custom']['web']['document_root'] do
  recursive true
end

# Add the site config
httpd_config 'default' do
  source 'default.conf.erb'
end

# Install apache
httpd_service 'default' do
  mpm 'prefork'
  action [:create, :start]
  subscribes :restart, 'httpd_config[default]'
end