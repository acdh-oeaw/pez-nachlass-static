import glob
import os
from collections import defaultdict
from acdh_tei_pyutils.tei import TeiReader
from acdh_xml_pyutils.xml import NSMAP


print("denoralize orgs")
files = glob.glob("./data/editions/*.xml")
doc = TeiReader("./data/indices/listorg.xml")

d = defaultdict(list)
for x in doc.any_xpath(".//tei:org[@xml:id]"):
    for ptr in x.xpath(".//tei:ptr", namespaces=NSMAP):
        filename = ptr.get("target")
        ptr.getparent().remove(ptr)
        d[filename].append(x)

for f in files:
    filename = os.path.basename(f)
    doc = TeiReader(f)
    root = doc.any_xpath(".//tei:profileDesc/tei:abstract")[0]
    for org in d[filename]:
        root.insert(org, 1)
    doc.tree_to_file(f)
    
