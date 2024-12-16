const iiifElement = document.getElementById('iiif');
const facsIds = Array.from(iiifElement.querySelectorAll('li')).map(li => li.textContent.trim());
const tileSource = facsIds.map(url => ({
    type: "image",
    url: `${url}?format=iiif`
}));

OpenSeadragon({
  id: "OsViewerDiv",
  prefixUrl: "vendor/openseadragon-bin-5.0.1/images/",
  sequenceMode: true,
  showReferenceStrip: true,
  tileSources: tileSource,
});
