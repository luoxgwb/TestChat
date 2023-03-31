FROM ghcr.io/zhayujie/chatgpt-on-wechat:latest

RUN pip install -U --no-cache-dir pip \
    && pip install --no-cache-dir pymysql==1.0.3

ENTRYPOINT ["/entrypoint.sh"]