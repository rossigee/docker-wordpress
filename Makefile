VERSION=5.4.2

all:
	docker build . -t rossigee/wordpress:${VERSION}
	docker push rossigee/wordpress:${VERSION}

