# jellyfin-Docker

增加时区和Umask设置，使用PUID PGID环境变量设置启动用户，无需手动更改文件夹权限，使用更加方便。

```bash
docker run -d \
 --name jellyfin \
 --env PUID=1000 \
 --env PGID=1000 \
 --env UMASK=022 \
 --env TZ=Asia/Shanghai \
 --net=host \
 --volume /path/to/config:/config \ # Alternatively --volume jellyfin-config:/config
 --volume /path/to/cache:/cache \ # Alternatively --volume jellyfin-cache:/cache
 --mount type=bind,source=/path/to/media,target=/media \
 --restart=unless-stopped \
 ddsderek/jellyfin
```

```yaml
version: '3.5'
services:
  jellyfin:
    image: ddsderek/jellyfin
    container_name: jellyfin
    network_mode: 'host'
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
      - /path/to/media2:/media2:ro
    restart: 'unless-stopped'
    # Optional - alternative address used for autodiscovery
    environment:
      - JELLYFIN_PublishedServerUrl=http://example.com
      - PUID=1000
      - PGID=1000
      - UMASK=022
      - TZ=Asia/Shanghai
    # Optional - may be necessary for docker healthcheck to pass if running in host network mode
    extra_hosts:
      - "host.docker.internal:host-gateway"
```