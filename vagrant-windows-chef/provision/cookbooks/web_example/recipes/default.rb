# install IIS
windows_feature 'IIS-WebServerRole' do
  action :install
end

# start the default web site
service 'w3svc' do
  action [:enable, :start]
end

file 'c:\inetpub\wwwroot\Default.htm' do
  content '<html>
  <body>
    <h1>hello world (provisioned by chef!)</h1>
  </body>
</html>'
end
