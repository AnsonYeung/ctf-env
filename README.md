# ctf-env
Backup of the important dotfiles and allow automatic setup of a container.
**NOTE: This is not a good use of docker.**

Run `docker-compose build` to build the image and `docker-compose run --rm ctf-env` to start a disposible shell.

Only the `/docker-share` directory inside the shell will be preserved!

> Note: If you run `sudo rm -rf / --no-preserve-root` then /docker-share directory will be wiped.
