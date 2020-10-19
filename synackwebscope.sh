
rm id.txt org.txt synackscopr.txt
curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer <<token>>'  --compressed | jq -r 'to_entries[] | " \(.value | .id)"' | tee id.txt

curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer <<token>>'  --compressed | jq -r 'to_entries[] | " \(.value | .organization_id)"' | tee org.txt

paste id.txt org.txt | while read if of
     do

curl 'https://platform.synack.com/api/asset/v1/organizations/'$of'/owners/listings/'$if'/webapps'   -H 'authority: platform.synack.com'   -H 'authorization: Bearer <<token>>'   --compressed  | jq -r '.[] | select(.status=="in") | .value' | sort -u >> synackscope.txt

done > AllScope.txt

