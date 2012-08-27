#
# Cookbook Name:: ssl-cert
# Recipe:: default
#
# Copyright 2012, AT&T Foundry
#
# All rights reserved - Do Not Redistribute

case node[:platform]
when "ubuntu", "debian"
  package "ssl-cert" do
    action :install
  end

  if not File.exists? "/etc/ssl/certs/ssl-cert-snakeoil.pem" then
    script "install_something" do
      interpreter "bash"
      user "root"
      code <<-EOH
      /usr/sbin/make-ssl-cert generate-default-snakeoil
      EOH
    end
  end
end

