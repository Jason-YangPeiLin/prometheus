#!/bin/bash
 **********************************************************
 * Author        : yangpeilin
 * Email         : peilin_yang@189.cn
 * Last modified : 2021-01-12
 * Filename      : nodeinstall.sh
 * Description   : 一键安装node_exporter,
                 : 将node_exporter添加到开机自启动项,
                 : 验证服务是否成功
 ********************************************************
echo "==========解压安装node exporter=========="
tar zxvf node_exporter-1.0.1.linux-amd64.tar.gz
mv node_exporter-1.0.1.linux-amd64 /usr/local/node_exporter
echo "==========创建systemd服务=========="
cat >> /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=node_exporter
After=network.target
[Service]
User=root
ExecStart=/usr/local/node_exporter/node_exporter
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
echo "==========启动node_exporter=========="
systemctl daemon-reload
systemctl start node_exporter
systemctl status node_exporter
systemctl enable node_exporter
echo "==========验证启动成功=========="
curl 127.0.0.1:9100/metrics
echo "==========安装完毕！============"

