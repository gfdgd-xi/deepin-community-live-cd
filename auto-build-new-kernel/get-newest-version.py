#!/usr/bin/env python3
import sys
import pyquery
mainVersion = int(sys.argv[1])
programVersionList = pyquery.PyQuery(url=f"https://www.kernel.org/")
#release = pyquery.PyQuery()
temp = 0
newestVersion = "0.0.0"
newestUrl = ""
for i in programVersionList(f"#releases tr :nth-child(2)").items():
    version = i("td strong").text()
    if temp == mainVersion:
        #print(version)
        version = version.strip()
        newestVersion = version
        if " " in version:
            newestVersion = version.split(" ")[0]
        break
    temp += 1

temp = 0
for i in programVersionList(f"#releases tr :nth-child(4)").items():
    url = i("td a").attr.href
    if temp == mainVersion:
        newestUrl = url
        break
    temp += 1
print(newestVersion)

print(newestUrl)
with open("/tmp/kernelversion.txt", "w") as file:
    file.write(newestVersion)
with open("/tmp/kernelurl.txt", "w") as file:
    file.write(newestUrl)
