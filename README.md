# synackwebapi
This is the result of my frustration that I was unable to automate my recon and content discovery.
this bash script is to get all the web app scope in synack, you need to be connected to the VPN.

download the bash script and replace your token in place of <<token>>( credit @ozguralp)

If you are intereseted you can tweak this script a bit to get credentials for the URL's, this is in pipeline will update shortly.

A folder will be created as WebScope+date and all results will be stred in it 
your scope will be visible in Allscope.txt along with credentials if the target has it
rules.txt tells you what are the rules of the domain
all wildcard scope is stored in stardomains.txt
Results in reconinput.txt can be integrated with any tools you have to enumerate subdomains
scopeforkid.txt has only URL's

Ideas from @SriTharun3 :)
Thanks Aslarchergore for pointing out out-of-scope urls


USAGE:
**bash WebScope.sh <<YourSynackAPI::key>>**
