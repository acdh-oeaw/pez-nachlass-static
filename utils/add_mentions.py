import glob
import os
from collections import defaultdict
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader
from acdh_xml_pyutils.xml import NSMAP

print("adds mentions as into tei:profileDesc, see #2")

d = defaultdict(list)
doc = TeiReader("data/indices/listperson.xml")
for x in doc.any_xpath(".//tei:person[@xml:id]"):
    for y in x.xpath(".//tei:ptr", namespaces=NSMAP):
        file = y.attrib["target"].split("/")[-1]
        d[file].append(
            {
                "type": y.attrib["type"],
                "node": x
            }
        )

for x in sorted(glob.glob("./data/editions/*.xml")):
    f_name = os.path.split(x)[-1]
    try:
        items = d[f_name]
    except KeyError:
        continue
    doc = TeiReader(x)
    for bad in doc.any_xpath(".//tei:profileDesc/tei:abstract"):
        bad.getparent().remove(bad)
    root = doc.any_xpath(".//tei:profileDesc")[0]
    ab = ET.Element("{http://www.tei-c.org/ns/1.0}abstract")
    listperson = ET.Element("{http://www.tei-c.org/ns/1.0}listPerson")
    ab.append(listperson)
    root.insert(0, ab)
    for item in items:
        for bad in item["node"].xpath(".//tei:ptr", namespaces=NSMAP):
            bad.getparent().remove(bad)
        item["node"].attrib["role"] = item["type"]
        listperson.append(item["node"])
    doc.tree_to_file(x)
