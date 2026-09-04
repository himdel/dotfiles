#!/bin/sh
inventory="$1"
grep "gateway_base_url" "$inventory"
grep "automationgateway_admin_password" "$inventory"
