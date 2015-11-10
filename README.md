## Workflow
* ExaBGP forks new process (exazk.rb);
* exazk.rb is trying to acquire mutex on ZK:
  * on success - announce routes and write some information to ZK about master node;
  * on failure - withdraw routes and spin around trying to acquire mutex once again.

## Requirements
* Zookeeper
* ExaBGP
* Ruby
* zk rubygem

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

