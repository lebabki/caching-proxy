# docker-compose для кеширующих прокси

Используются прокси для нескольких docker-registry и для rpm репозиториев.

Смотри [github.com/rpardini/docker-registry-proxy - README.md](https://github.com/rpardini/docker-registry-proxy/blob/master/README.md) и

Необходимо скопировать .env.example и адаптировать значения.

После запуска нужно добавить ca в цепочку доверенных в системе:

```bash
sudo ln -sf $(pwd)/ca/ca.crt /etc/pki/ca-trust/source/anchors/caching-proxy.pem
sudo update-ca-trust
```

При необходимости добавь в доверенные в ВМ тестовых стендов на стадии `vagrant provision`.
