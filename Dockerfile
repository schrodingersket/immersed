FROM debian:stretch

ENV NO_AT_BRIDGE=

# Install dependencies - Firefox installed for
# code authentication.
#
RUN apt-get update -y && \
    apt-get install -y curl \
                       desktop-file-utils \
                       firefox-esr \
                       gnupg \
                       jq \
                       libcurl3-gnutls \
                       libgtk-3-0 \
                       libpng16-16 \
                       libsm6 \
                       libva-dev \
                       libxxf86vm1 \
                       wget \
                       xdg-utils

# Port exposure
#
EXPOSE 51000
EXPOSE 58093
EXPOSE 52000-63000

# Immersed args
#
ARG IMMERSED_CODE_PREFIX=LastScheme=immersed://signin?info=
ARG IMMERSED_CONF_FILE=/root/.ImmersedConf
ARG IMMERSED_DATA_DIR=/root/.Immersed
ARG IMMERSED_OCULUS_KEY=
ARG IMMERSED_VERSION=1.1.1
ARG IMMERSED_USERNAME=

# Install Immersed
#
RUN TEMP_DEB="$(mktemp)" && \
    wget -O "$TEMP_DEB" 'https://immersedvr.com/dl/Immersed_amd64.deb' && \
    dpkg -i "$TEMP_DEB" && \
    rm -f "$TEMP_DEB"

# Configure JWT token for .ImmersedConf
#
RUN echo "$IMMERSED_CODE_PREFIX$(curl --silent --show-error --fail https://api.immersedvr.com/authorizeUserFromKey?oculus_key=$IMMERSED_OCULUS_KEY | jq -r '.body.info')" > $IMMERSED_CONF_FILE && \
    echo "Name=$IMMERSED_USERNAME" >> $IMMERSED_CONF_FILE

# Run Immersed binary
#
CMD /usr/local/bin/Immersed
