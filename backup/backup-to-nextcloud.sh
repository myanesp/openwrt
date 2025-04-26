#!/bin/sh

# Change to your Nextcloud instance data and the name of your host 
NEXTCLOUD_URL="https://my.nextcloud.com"
APP_TOKEN="xxx-xxx-xxx-xxx"
USERNAME="me" # only user, not email
UPLOAD_PATH="remote.php/dav/files/$USERNAME/OpenWRT-Backup"
ROUTER_NAME="openwrt1"

directory_exists() {
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $APP_TOKEN" -X PROPFIND "$NEXTCLOUD_URL/$1")
    if [ "$response" -eq 207 ]; then
        return 0
    else
        return 1
    fi
}

create_directory() {
    if ! directory_exists "$1"; then
        curl -X MKCOL -H "Authorization: Bearer $APP_TOKEN" "$NEXTCLOUD_URL/$1"
    fi
}

create_directory "$UPLOAD_PATH"

BACKUP_FILE="/tmp/openwrt_${ROUTER_NAME}_backup_$(date +%Y%m%d%H%M%S).tar.gz"
sysupgrade -b $BACKUP_FILE

curl -H "Authorization: Bearer $APP_TOKEN" -T $BACKUP_FILE "$NEXTCLOUD_URL/$UPLOAD_PATH/$(basename $BACKUP_FILE)"

rm $BACKUP_FILE

echo "Backup uploaded to Nextcloud successfully!"
