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

