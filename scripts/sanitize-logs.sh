#!/bin/bash
echo "Sanitizing IPs in logs..."

find /location/logs/ -type f -name "*.log" | while read file; do
  echo "Masking IPs in: $file"
  sed -i 's/[0-9]\{1,3\}\(\.[0-9]\{1,3\}\)\{3\}/xxx.xxx.xxx.xxx/g' "$file"
done

echo "Done. All IPs masked."
