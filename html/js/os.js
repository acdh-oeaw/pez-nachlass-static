    const iiifContent = document.getElementById('iiif').textContent;
    const tileSource = JSON.parse(iiifContent);

    OpenSeadragon({
        id:             "OsViewerDiv",
        prefixUrl:      "/vendor/openseadragon-bin-5.0.1/images/",
        sequenceMode: true,
        showReferenceStrip:  true,
        tileSources: tileSource
    });