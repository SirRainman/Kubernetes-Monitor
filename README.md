# Kubernetes-Monitor
1 选定一个主机作为NFS-Server

2 在server上创建共享文件目录

```shell
# 创建共享文件目录
mkdir -p /root/Kubernetes-Monitor/grafana/grafana_data

# 给目录增加读写权限
chmod a+rw -R /root/Kubernetes-Monitor/grafana/grafana_data
```

3 在Kubernetes集群上安装nfs工具

```shell
apt-get update
apt-get install -y nfs-kernel-server
apt-get install -y nfs-common
```

4 在NFS-server上，为共享文件夹添加可访问nfs的客户端

![image-20210426130800446](http://haoimg.hifool.cn/img/image-20210426130800446.png)

````shellku
# 配置NFS服务目录，打开vim /etc/exports 在末尾加上
/root/Kubernetes-Monitor/grafana/grafana_data *(insecure,rw,sync,no_subtree_check,no_root_squash)

# /root/Kubernetes-Monitor/grafana/grafana_data：作为服务目录向客户端开放
# *：表示任何IP都可以访问
# rw：读写权限
# sync：同步权限
# no_subtree_check：表示如果输出目录是一个子目录，NFS服务器不检查其父目录权限
# no_root_squash：客户端连接服务端时如果使用的是root，那么也拥有对服务端分享的目录的root权限
````



5 NFS-server端重启服务，使配置生效

```shell
/etc/init.d/nfs-kernel-server restart
```



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