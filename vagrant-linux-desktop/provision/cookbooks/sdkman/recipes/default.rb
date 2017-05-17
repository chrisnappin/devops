home = "/home/vagrant"
sdkman = "#{home}/.sdkman"

# install/update sdkman for the vagrant user
bash 'install_sdkman' do
  cwd "#{home}"
  user 'vagrant'
  group 'vagrant'
  environment ({'HOME' => "#{home}", 'USER' => 'vagrant'})
  code <<-EOH
    export SDKMAN_DIR="#{sdkman}" && curl -s "https://get.sdkman.io" | bash
    EOH
  not_if { ::File.exist?("#{sdkman}") }
end

# install configuration
cookbook_file "#{sdkman}/etc/config" do
  backup false
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
end

# install/update sdks
bash 'install_sdks' do
  cwd "#{home}"
  user 'vagrant'
  group 'vagrant'
  environment ({'HOME' => "#{home}", 'USER' => 'vagrant'})
  code <<-EOH
    source "#{sdkman}/bin/sdkman-init.sh"
	sdk install java 8u131
	sdk default java 8u131
	sdk install scala 2.11.7
	sdk default scala 2.11.7
	sdk install sbt 0.13.11
	sdk default sbt 0.13.11
	sdk install gradle 3.5
	sdk default gradle 3.5
	sdk install springboot 1.5.3.RELEASE
	sdk default springboot 1.5.3.RELEASE
    EOH
end