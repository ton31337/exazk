require 'zk'
require 'socket'
require 'json'

class ExaZK
  def initialize(mutex, zk_string, routes, data)
    @mutex = mutex
    @zk_string = zk_string
    @routes = routes
    @data = {
      hostname: Socket.gethostname,
      data: data
    }.to_json
    @zk = ZK.new(@zk_string)
  end

  def send_update(route)
    $stdout.write route
    $stdout.flush
  end

  def withdraw_routes
    @routes.map do |route|
      route % 'withdraw'
    end
  end

  def announce_routes
    @routes.map do |route|
      route % 'announce'
    end
  end

  def mutex_exists?
    if @zk.exists?(@mutex)
      data = JSON.parse(@zk.get(@mutex).first)
      return true if data['hostname'] == Socket.gethostname
    else
      begin
        @zk.create(@mutex, "#{@data}", :ephemeral => true)
        return true
      rescue ZK::Exceptions::NodeExists
        return false
      end
    end
  end

  def main_loop
    withdraw_routes.each do |route|
      send_update(route)
    end unless mutex_exists?

    announce_routes.each do |route|
      send_update(route)
    end if mutex_exists?
  end
end
