#
# Cookbook Name:: ssl-cert
# Recipe:: databag
#
# Copyright 2012, AT&T Foundry
#
# Licensed under the Apache License, Version 2.0

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
