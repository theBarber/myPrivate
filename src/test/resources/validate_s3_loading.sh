cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs
tac temp_logs | egrep -o -m1 [_[:alnum:]]+\.json > temp_file_name
rm temp_logs

