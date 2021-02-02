# Kubernetes-Monitor

# 1 Prometheus Job 问题
1. prometheus configmap中，node-exporter的地址怎么填写？因为每个主机上都有node-exporter的pod，这个pod的地址是不断的变化的，应该怎么填写这个地址？？？
2. 为什么同样的配置文件，就可以监控promtheus而不可以监控node-exporter？？？是不是因为这个job是在promtheus的容器中执行的，可以通过prometheus容器的localhost找到自己？？？
```yaml
- job_name: 'prometheus'
    static_configs:
    - targets:
        - "localhost:9090"

- job_name: 'kubernetes-node-exporter'
    static_configs:
    - targets:
    - "localhost:9100"
```
3. kubernetes-node 和 node-exporter之间的联系和区别是什么？
4. 为什么监控到的 pods 和 service 是处于down状态的？