# install the binaries
package "apache2" do
  action :install
end

# symlink docroot to vagrant source
link "/var/www/src" do
  to "/vagrant/src"
end

# set configuration of a virtual host, applied after install and before restart
cookbook_file "/etc/apache2/sites-available/000-default.conf" do
  backup false
  action :create
  notifies :restart, "service[apache2]", :delayed
end

# configure the init server, and start it up
service "apache2" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end