#
# Cookbook Name:: LAMP
# Recipe:: igusan
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "httpd" do
	action :install
end

template "/etc/httpd/conf/httpd.conf" do
	source "httpd.conf.erb"
	owner "root"
	group "root"
	mode "0644"
end

package "mysql" do
	action :install
end

%w{php php-common php-mbstring php-xml php-devel php-process php-cli  php-mysql mysql-server php-pdo gd-devel curl-devel}.each do |p|
    package p do
        action :install
    end
end

service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start ]
end

bash "stert_page" do
	user "root"
	cwd "/var/www/html/"
	code <<-EOH
	echo "<?php phpinfo(); " > index.php
	EOH
end
service "mysqld" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

