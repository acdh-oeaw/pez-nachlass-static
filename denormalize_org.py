import glob
import os
import lxml.etree as ET
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
    for x in root.xpath(".//tei:org", namespaces=NSMAP):
        x.getparent().remove(x)
    listorg = ET.Element("{http://www.tei-c.org/ns/1.0}listOrg")
    root.insert(1, listorg)
    for org in d[filename]:
        listorg.append(org)
    doc.tree_to_file(f)

print("now lets delete all empty listPerson and listOrg elements")

for f in files:
    doc = TeiReader(f)
    for empty_node in doc.any_xpath(".//tei:listPerson[not(node())] | .//tei:listOrg[not(node())]"):
        empty_node.getparent().remove(empty_node)
    for empty_abstract in doc.any_xpath(".//tei:profileDesc/tei:abstract[not(node())]"):
        empty_ab = ET.Element("{http://www.tei-c.org/ns/1.0}ab")
        empty_abstract.append(empty_ab)
    doc.tree_to_file(f)
