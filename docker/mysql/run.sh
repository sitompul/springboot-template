docker build -t mysql_8_image . --no-cache && docker run -d -p 3306:3306 --name mysql_8_instance mysql_8_image
