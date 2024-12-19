import glob
import os
import json
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import extract_fulltext
from collections import defaultdict


print("Hello, I am a script that creates a list of all bibl entries in the editions.")
files = glob.glob("data/editions/*.xml")

d = defaultdict(dict)
for x in files:

    doc = TeiReader(x)
    for bibl in doc.any_xpath(".//tei:rs[@type='bibl']"):
        heads, tail = os.path.split(x)
        id = bibl.attrib["key"].split(":")[1]
        if id.startswith("r"):
            d[id]["title"] = extract_fulltext(bibl)
            if "mentiones" not in d[id]:
                d[id]["mentiones"] = list()
            d[id]["mentiones"].append(
                {
                    "file": tail,
                    "doc_title": doc.any_xpath(".//tei:titleStmt/tei:title")[0].text,
                }
            )


with open("hansi.json", "w", encoding="utf-8") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)

template = """
<TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
   <teiHeader>
      <fileDesc>
         <titleStmt>
            <title>Bibliographie</title>
         </titleStmt>
         <publicationStmt>
            <p>Publication Information</p>
         </publicationStmt>
         <sourceDesc>
            <p>born digital, created with make_listbibls.py</p>
         </sourceDesc>
      </fileDesc>
   </teiHeader>
   <text>
      <body>
         <p>Some text here.</p>
         <listBibl />
      </body>
   </text>
</TEI>
"""

doc = TeiReader(template)
listbibl = doc.any_xpath(".//tei:listBibl")[0]
for key, value in d.items():
    bibl = ET.Element("{http://www.tei-c.org/ns/1.0}bibl")
    bibl.attrib["{http://www.w3.org/XML/1998/namespace}id"] = key
    title = ET.Element("{http://www.tei-c.org/ns/1.0}title")
    title.text = value["title"]
    bibl.append(title)
    for mention in value["mentiones"]:
        ptr = ET.Element("{http://www.tei-c.org/ns/1.0}ptr")
        ptr.attrib["target"] = mention["file"]
        ptr.attrib["n"] = mention["doc_title"]
        bibl.append(ptr)
    listbibl.append(bibl)
doc.tree_to_file("data/indices/listbibl.xml")

print("Done.")
