#!/usr/bin/ruby
require 'zk'

mutex = '/mutex'
wait_create = 2
zk_connection_string = '10.0.0.101:2181,10.0.0.102:2181,10.0.0.103:2181/exazk'
announce_routes = [ "announce route 192.168.14.2/32 next-hop 192.168.1.1\n" ]
withdraw_routes = [ "withdraw route 192.168.15.3/32 next-hop 192.168.1.1\n" ]
data = {
  'master' => `hostname | tr -d '\n'`
}

def create_loop(zk, mutex, data)
  begin
    zk.create(mutex, "#{data}", :ephemeral => true)
    return true
  rescue ZK::Exceptions::NodeExists
    return false
  end
end

def send_update(route)
  $stdout.write route
  $stdout.flush
end

zk = ZK.new(zk_connection_string)
while !create_loop(zk, mutex, data)
        withdraw_routes.each do |route|
          send_update(route)
        end
        sleep wait_create
end

announce_routes.each do |route|
  send_update(route)
end

while true
  sleep 1
end
