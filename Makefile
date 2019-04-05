PROJECT = emqx_kafka_bridge
PROJECT_DESCRIPTION = EMQ X Kafka Bridge
PROJECT_VERSION = 3.0

DEPS = ekaf
dep_ekaf = git https://github.com/helpshift/ekaf master

BUILD_DEPS = emqttd cuttlefish
dep_emqx = git-emqx https://github.com/emqx/emqx emqx30
dep_cuttlefish = git-emqx https://github.com/emqx/cuttlefish v2.2.1

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'
# TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'

NO_AUTOPATCH = cuttlefish

COVER = true

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_kafka_bridge.conf -i priv/emqx_kafka_bridge.schema -d data
