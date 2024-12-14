import pandas as pd
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import make_entity_label
from acdh_xml_pyutils.xml import NSMAP


print("adding gnds from 'gnd.csv' and fixing persName labels")

df = pd.read_csv("gnd.csv")
lookup_dict = df.set_index("name")["gnd"].to_dict()
doc = TeiReader("data/indices/listperson.xml")
for x in doc.any_xpath(".//tei:person[@xml:id]"):
    pers_name = make_entity_label(
        x.xpath("./tei:persName/tei:persName[2]", namespaces=NSMAP)[0]
    )[0]
    key = make_entity_label(
        x.xpath("./tei:persName/tei:persName[2]", namespaces=NSMAP)[0]
    )[0].replace(", ", " ")
    for bad in x.xpath("./tei:persName", namespaces=NSMAP):
        bad.getparent().remove(bad)
    new_node = ET.Element("{http://www.tei-c.org/ns/1.0}persName")
    new_node.text = pers_name
    x.insert(0, new_node)
    try:
        gnd = lookup_dict[key]
    except KeyError:
        gnd = False
    if gnd:
        new_node = ET.Element("{http://www.tei-c.org/ns/1.0}idno")
        new_node.text = gnd.split(" ")[0]
        x.insert(1, new_node)
doc.tree_to_file("lisperson.xml")
