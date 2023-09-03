#!/usr/bin/env python3
import os
import sys
import requests
import pyquery
mainVersion = int(sys.argv[1])
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8'
}
get = requests.get("https://www.xanmod.org/", headers=headers).text
programVersionList = pyquery.PyQuery(get)
print(programVersionList)
#release = pyquery.PyQuery()
temp = 0
newestVersion = "0.0.0"
newestUrl = ""
for i in programVersionList(f"#content div.page div.level3 :first-child td a").items():
    print(i)
    if ".tar" in i.attr.href:
        if temp == mainVersion:
            newestVersion = os.path.splitext(os.path.splitext(os.path.basename(i.attr.href))[0])[0]
            newestUrl = i.attr.href
            break
        temp += 1
    #print(i)

print(newestVersion)
print(newestUrl)
with open("/tmp/kernelversion.txt", "w") as file:
    file.write(newestVersion)
with open("/tmp/kernelurl.txt", "w") as file:
    file.write(newestUrl)
