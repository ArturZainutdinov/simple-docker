#!/bin/bash
miniserver nginx start
nginx -s reload
spawn-fcgi -p 8080 a.out

while true; do
        wait
done