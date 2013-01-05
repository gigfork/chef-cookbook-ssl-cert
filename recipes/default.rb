#
# Cookbook Name:: ssl-cert
# Recipe:: default
#
# Copyright 2012, AT&T Foundry
#
# Licensed under the Apache License, Version 2.0

if node['ssl-cert']['snakeoil'] then
  include_recipe "ssl-cert::snakeoil"
end
