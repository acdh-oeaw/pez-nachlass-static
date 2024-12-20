import glob
import os

from typesense.api_call import ObjectNotFound
from acdh_cidoc_pyutils import extract_begin_end
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import (
    extract_fulltext,
    get_xmlid,
    make_entity_label,
)
from tqdm import tqdm


files = glob.glob("./data/editions/*.xml")
tag_blacklist = [
    "{http://www.tei-c.org/ns/1.0}abbr",
    "{http://www.tei-c.org/ns/1.0}del",
]

COLLECTION_NAME = "pez-nachlass"
MIN_DATE = 1000


try:
    client.collections[COLLECTION_NAME].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": COLLECTION_NAME,
    "enable_nested_fields": True,
    "fields": [
        {"name": "id", "type": "string", "sort": True},
        {"name": "rec_id", "type": "string", "sort": True},
        {"name": "title", "type": "string", "sort": True},
        {"name": "full_text", "type": "string", "sort": True},
        {"name": "category", "type": "string", "facet": True, "sort": True},
        {
            "name": "year",
            "type": "int32",
            "optional": True,
            "facet": True,
            "sort": True,
        },
        {"name": "persons", "type": "object[]", "facet": True, "optional": True},
        {"name": "orgs", "type": "object[]", "facet": True, "optional": True},
        {"name": "works", "type": "object[]", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)
dates = set()
records = []
for x in tqdm(files, total=len(files)):
    record = {}

    doc = TeiReader(x)
    try:
        body = doc.any_xpath(".//tei:teiHeader")[0]
    except IndexError:
        continue
    record["id"] = os.path.split(x)[-1].replace(".xml", "")

    record["rec_id"] = os.path.split(x)[-1].replace(".xml", "")
    record["title"] = extract_fulltext(
        doc.any_xpath(".//tei:titleStmt/tei:title[1]")[0]
    )
    record["category"] = doc.any_xpath(".//tei:classCode/text()")[0]
    try:
        date_node = doc.any_xpath(".//tei:origin/tei:date")[0]
        date_str = extract_begin_end(date_node)[0]
    except IndexError:
        date_str = MIN_DATE
    try:
        record["year"] = int(date_str[:4])
    except TypeError:
        record["year"] = MIN_DATE
    record["persons"] = []
    for y in doc.any_xpath(".//tei:person[@xml:id]"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        record["persons"].append(item)
    record["orgs"] = []
    for y in doc.any_xpath(".//tei:org[@xml:id]"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        record["orgs"].append(item)
    record["works"] = []
    for y in doc.any_xpath(".//tei:rs[@key]"):
        biblid = y.attrib["key"].split(":")[-1]
        bibltitle = y.text
        item = {"id": biblid, "label": bibltitle}
        record["works"].append(item)

    record["full_text"] = extract_fulltext(body, tag_blacklist=tag_blacklist)
    records.append(record)

make_index = client.collections[COLLECTION_NAME].documents.import_(records)
print(make_index)
print(f"done with indexing {COLLECTION_NAME}")
