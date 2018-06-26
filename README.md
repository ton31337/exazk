## Workflow
* ExaBGP forks new process (exazk.rb);
* exazk.rb is trying to acquire mutex on ZK:
  * on success - announce routes and write some information to ZK about master node;
  * on failure - withdraw routes and spin around trying to acquire mutex once again.

![](http://donatas.net/exazk-new.png)

## Requirements
* Zookeeper
* ExaBGP
* Ruby >= 2

## Install
* gem install exazk

## Recommendations
* set `minSessionTimeout` or `tickTime` (zookeeper) as low as you can, to have faster convergence.

## Configuration example
```
neighbor 10.0.0.1 {
    router-id 10.0.0.2;
    local-address 10.0.0.2;
    local-as 65501;
    peer-as 65501;
    hold-time 5;
    
    process announce-routes {
      run /etc/exabgp/exazk.rb;
    }
}
```

## Usage
```
require 'exazk'

zk_string = 'localhost:2181/exazk'
routes = [ "%s route 10.0.0.10/32 next-hop 1.1.1.1\n" ]

exazk = ExaZK.new('/mutex', zk_string, routes, 'mysql cluster #2')
while true
  exazk.main_loop
  sleep 5
end
```
