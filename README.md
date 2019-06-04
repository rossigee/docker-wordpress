# Wordpress Docker

Based on Ubuntu Bionic, with Nginx and PHP-FPM.

Can be extended and built with on-board document root (suitable for scaling deployments), or with document root mounted from a volume, which may/may not be scalable.

To build:

	docker build -t rossigee/wordpress .

To run:

	docker run --restart=always -d -p 80:80 --link wordpress-db:db -v wordpress-docroot:/srv/wordpress --name wordpress rossigee/wordpress

