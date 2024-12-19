import glob
import os
from acdh_tei_pyutils.tei import TeiReader

print("adds titles to ptr elements in listperson.xml")
files = glob.glob("./data/editions/*.xml")
url = "https://id.acdh.oeaw.ac.at/pez/pez-nachlass/"

lookup = dict()
for x in files:
    filename = os.path.split(x)[1]
    doc = TeiReader(x)
    title = doc.any_xpath(".//tei:titleStmt/tei:title[@type='main']/text()")[0]
    lookup[f"{url}{filename}"] = title


doc = TeiReader("./data/indices/listperson.xml")
for x in doc.any_xpath(".//tei:ptr[@target]"):
    ptrid = x.attrib["target"]
    print(ptrid)
    try:
        title = lookup[ptrid]
    except KeyError:
        print(ptrid)
        continue
    x.attrib["n"] = title
doc.tree_to_file("./data/indices/listperson.xml")
