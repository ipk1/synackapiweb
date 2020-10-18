
rm id.txt org.txt synackscopr.txt
curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer <<token>>'   -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'   -H 'Accept: */*'   -H 'Sec-Fetch-Site: same-origin'   -H 'Sec-Fetch-Mode: cors'   -H 'Sec-Fetch-Dest: empty'   -H 'Referer: https://platform.synack.com/targets'   -H 'Accept-Language: en-US,en;q=0.9'   --compressed | jq -r 'to_entries[] | " \(.value | .id)"' | tee id.txt

curl 'https://platform.synack.com/api/targets/registered_summary'   -H 'Connection: keep-alive'   -H 'Authorization: Bearer <<token>>'   -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'   -H 'Accept: */*'   -H 'Sec-Fetch-Site: same-origin'   -H 'Sec-Fetch-Mode: cors'   -H 'Sec-Fetch-Dest: empty'   -H 'Referer: https://platform.synack.com/targets'   -H 'Accept-Language: en-US,en;q=0.9'   --compressed | jq -r 'to_entries[] | " \(.value | .organization_id)"' | tee org.txt

paste id.txt org.txt | while read if of
     do

curl 'https://platform.synack.com/api/asset/v1/organizations/'$of'/owners/listings/'$if'/webapps'   -H 'authority: platform.synack.com'   -H 'authorization: Bearer <<token>>'   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36'   -H 'dnt: 1'   -H 'accept: */*'   -H 'sec-fetch-site: same-origin'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-dest: empty'   -H 'referer: https://platform.synack.com/targets/398mb7b0p5/scope'   --compressed  | jq -r 'to_entries[] | " \(.value | .value)"' | sort -u >> synackscope.txt

done > AllScope.txt

