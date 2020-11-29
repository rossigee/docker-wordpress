VERSION=5.5.3

all:
	docker build . -t rossigee/wordpress:${VERSION}
	docker push rossigee/wordpress:${VERSION}

