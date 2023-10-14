#!/bin/bash

# Create a folder with the name "Webscope" and current date
folder_name="Webscope_$(date +%Y%m%d)"
mkdir -p "$folder_name"

# Remove all txt files in the current directory
# Remove this line if you don't want to delete existing txt files.
# rm *.txt

# Your existing code with modifications to store results in the new folder
curl 'https://platform.synack.com/api/targets/registered_summary' -H 'Connection: keep-alive' -H "Authorization: Bearer $1" --compressed | jq -r 'to_entries[] | " \(.value | .id)"' | tee "${folder_name}/id.txt"
curl 'https://platform.synack.com/api/targets/registered_summary' -H 'Connection: keep-alive' -H "Authorization: Bearer $1" --compressed | jq -r 'to_entries[] | " \(.value | .organization_id)"' | tee "${folder_name}/org.txt"

paste "${folder_name}/id.txt" "${folder_name}/org.txt" | while read if of; do
    curl "https://platform.synack.com/api/targets/$if" -H 'authority: platform.synack.com' -H "Authorization: Bearer $1" --compressed | jq '.codename' >> "${folder_name}/Allscopenew.txt"

    curl "https://platform.synack.com/api/asset/v2/assets?listingUid%5B%5D=$if&organizationUid%5B%5D=$of&assetType%5B%5D=webapp&active=true&sort=location&sortDir=asc&page=1&perPage=5000" -H 'authority: platform.synack.com' -H "Authorization: Bearer $1" --compressed | jq -r '.[] | select(.status=="valid") | .webApplication.url' | sort -u >> "${folder_name}/Allscopenew.txt"
done

sudo cat "${folder_name}/Allscopenew.txt" | grep -v '"' >> "${folder_name}/scopeforkid.txt"

paste "${folder_name}/id.txt" "${folder_name}/org.txt" | while read if of; do
    curl "https://platform.synack.com/api/targets/$if" -H 'authority: platform.synack.com' -H "Authorization: Bearer $1" --compressed | jq '.codename' >> "${folder_name}/rules.txt"

    curl "https://platform.synack.com/api/asset/v2/assets?listingUid%5B%5D=$if&organizationUid%5B%5D=$of&assetType%5B%5D=webapp&active=true&sort=location&sortDir=asc&page=1&perPage=5000" -H 'authority: platform.synack.com' -H "Authorization: Bearer $1" --compressed | jq -r '.[] | select(.status=="valid") | .scopeRules[].rule' | sort -u | sort -u >> "${folder_name}/rules.txt"
done

sudo cat "${folder_name}/rules.txt"  | grep -v '.www' | cut -d / -f 1 | cut -d : -f 1 >> "${folder_name}/reconinput.txt"
sudo cat "${folder_name}/rules.txt" | grep '*.' | sort -u | tee "${folder_name}/stardomains.txt"
