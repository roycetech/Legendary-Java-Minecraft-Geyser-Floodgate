IMAGE_NAME=roycetech/minecraft-server
VOLUME_NAME=minecraft-server-volume-rye
VOLUME_NAME=minecraft-server-volume

create-volume:
	docker volume create $(VOLUME_NAME)

build:
	docker build \
		-f arm64v8.Dockerfile \
		-t $(IMAGE_NAME) .

start:
	docker run -it \
		-v $(VOLUME_NAME):/minecraft \
		-p 25565:25565 \
		-p 19132:19132/udp \
		-p 19132:19132 \
		-p 10273:10273 \
		--restart unless-stopped $(IMAGE_NAME)

push:
	docker push roycetech/minecraft-server

original:
	docker run -it \
		-v minecraft-server-volume:/minecraft \
		-p 25565:25565 \
		-p 19132:19132/udp \
		-p 19132:19132 \
		-p 10273:10273 \
		--restart unless-stopped 05jchambers/legendary-minecraft-geyser-floodgate:latest

get-local-ip:
	 ifconfig | grep -A 4 -e en0: | grep -m 1 -o -E '\d+\.\d+\.\d+\.\d+' | sed '1q;d'