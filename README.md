# synackwebapi
This is the result of my frustration that I was unable to automate my recon and content discovery.
this bash script is to get all the web app scope in synack, you need to be connected to the VPN.

download the bash script and replace your token in place of <<token>>( credit @ozguralp)

this was made after looking at ozguralp's code for Host targets, but since I dont know python, this is in Bash.( tested in MacOS and works)
if you are intereseted you can tweak this script a bit to get credentials for the URL's, this is in pipeline will update shortly.


your scope will be visible in Allscope.txt along with credentials if the target has it

Ideas from @SriTharun3 :)
Thanks Aslarchergore for pointing out out-of-scope urls


##the target_&_scope.sh will download the scope as follows

"ladybird"
  
https://url.com

  url1.com
.
  
.
  
"CREDENTIALS"

USERNAME:124
  
PASSWORD:JHGGH%&^&*

USAGE:
**bash scope_creds.sh <<YourSynackAPI::key>>**
