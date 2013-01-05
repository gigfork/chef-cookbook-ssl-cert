#
# Cookbook Name:: ssl-cert
# Recipe:: databag
#
# Copyright 2012, AT&T Foundry
#
# Licensed under the Apache License, Version 2.0

# FIXME: unfortunately, this code is evaluated during compile time and 
# node['fqdn'] resolves to the hostname _before_ the hostname cookbook changes it
# this results in a failed data bag look up. The second run evaluates correctly.
# I tried wrapping this in a ruby_block, but then the helpers cookbook library
# functions are not available, particularly the encrypted_data_bag method. 

begin 
  bag_id = node["fqdn"].gsub(".","-")
  bag    = node['ssl-cert']['databag']['name']
  site   = encrypted_data_bag(bag, bag_id).to_hash
  site.delete('id')

  site.each do |dest, cert|
    file dest.dup do
      owner "root"
      group "root"
      content cert  
      mode 00644
      action :create
    end 
  end
rescue Net::HTTPServerException
  Chef::Log.warn "No site data bags found for #{node['fqdn']}"
end

