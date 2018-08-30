#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
group 'tomcat'

user 'tomcat' do
  group 'tomcat'
  system true
  shell '/bin/bash'
end

yum_package 'unzip'

yum_package 'java-1.8.0-openjdk'

ark 'tomcat' do
  url 'http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.33/bin/apache-tomcat-8.5.33.tar.gz'
  home_dir '/opt/tomcat'
  version '8.5.33'
  owner 'tomcat'
  group 'tomcat'
end

remote_file '/opt/tomcat/lib/mysql-connector-java.jar' do
  source 'https://github.com/Glebk0/untitled/blob/master/mysql-connector-java-8.0.12.jar'
  notifies :restart, 'systemd_unit[tomcat.service]', :immediately
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

systemd_unit 'tomcat.service' do
  action [:enable, :start]
end

template "/opt/tomcat/conf/server.xml" do
  source 'server.conf.xml.erb'
  mode '0755'
  owner 'tomcat'
  group 'tomcat'
  notifies :restart, 'systemd_unit[tomcat.service]', :immediately
end

dbservers = ''
search(:node, "name:db-node") do |n|
    dbservers << n["hostname"]
end

template "/opt/tomcat/conf/context.xml" do
  source 'context.xml.erb'
  mode '0755'
  owner 'tomcat'
  group 'tomcat'
  notifies :restart, 'systemd_unit[tomcat.service]', :immediately
  variables :dbservers => dbservers
end

remote_file "/opt/tomcat/webapps/demo.war" do
  source 'https://github.com/Glebk0/untitled/blob/master/demojndi.war'
end