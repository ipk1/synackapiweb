mkdir synack
cd synack
rm *.txt
curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer '$1''   --compressed | jq -r 'to_entries[] | " \(.value | .id)"' | tee id.txt
curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer '$1''   --compressed | jq -r 'to_entries[] | " \(.value | .organization_id)"' | tee org.txt

paste id.txt org.txt | while read if of
     do
      curl 'https://platform.synack.com/api/targets/'$if''   -H 'authority: platform.synack.com'   -H 'authorization: Bearer '$1''  --compressed | jq '.codename' >> Allscope.txt
curl 'https://platform.synack.com/api/asset/v1/organizations/'$of'/owners/listings/'$if'/webapps'   -H 'authority: platform.synack.com'   -H 'authorization: Bearer '$1''   --compressed  | jq -r '.[] | select(.status=="in") | .value' | sort -u >> Allscope.txt
echo "CREDENTIALS" >> Allscope.txt
curl 'https://platform.synack.com/api/asset/v1/organizations/'$of'/owners/listings/'$if'/users/tldyy9wiqv/credentials'  -X 'POST' -H 'authority: platform.synack.com' -H 'content-length: 0'  -H 'authorization: Bearer '$1'' | jq -r '.[] | .credentials[] ' | tr -d '{}' | sed  '/^[[:space:]]*$/d' >> Allscope.txt

done
