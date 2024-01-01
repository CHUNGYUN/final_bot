import requests
url = "https://apply.lh.or.kr/lhapply/apply/wt/wrtanc/selectWrtancList.do?mi=1026"
response = requests.get(url)
print(response)

from bs4 import BeautifulSoup
soup = BeautifulSoup(response.text, "html.parser")
print(soup)
schedule = soup.find("div", class_="today_schedule")

print(schedule.text)
# or
with open("log/schedule.txt", "w") as f:
    f.write(schedule.text)
