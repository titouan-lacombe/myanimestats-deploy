# Create .env file if it does not exist
$(shell ./setup_env.sh 1>&2)

include .env

PUID=$(shell id -u)
PGID=$(shell id -g)

SEPARATOR := $(shell bash -c 'if [[ "${DOMAIN}" == *.*.* ]]; then echo "-"; else echo "."; fi')
# APP_DOMAIN := $(shell if [ "${ENV}" = "pro" ]; then echo ${DOMAIN}; else echo ${ENV}${SEPARATOR}${DOMAIN}; fi)
APP_DOMAIN := myanimestats${SEPARATOR}${DOMAIN}

export

COMPOSE=docker compose

default: up

mkdata:
	@mkdir -p data data

build:
	@$(COMPOSE) build

up: mkdata
	@$(COMPOSE) up -d

rebuild: mkdata
	@$(COMPOSE) up -d --build

recreate: mkdata
	@$(COMPOSE) up -d --force-recreate

down:
	@$(COMPOSE) down  --remove-orphans

restart:
	@$(COMPOSE) restart

ps:
	@$(COMPOSE) ps

stats:
	@$(COMPOSE) stats

logs:
	@$(COMPOSE) logs app -f --tail=100

attach:
	@$(COMPOSE) exec app bash
