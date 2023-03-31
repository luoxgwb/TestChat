FROM ghcr.io/zhayujie/chatgpt-on-wechat:latest

RUN pip install -i pymysql==1.0.3

ENTRYPOINT ["/entrypoint.sh"]