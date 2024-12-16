table.on("tableBuilt", () => {
  const typeUniqueValues = [...new Set(table.getData().map((row) => row.typ))];

  table.getColumn("typ").updateDefinition({
    headerFilter: "select", // Change to a dropdown filter
    headerFilterParams: {
      values: [
        { value: "", label: "----" }, // Label for the empty string
        ...typeUniqueValues.map((value) => ({
          value,
          label: value,
        })),
      ],
    //   valuesLookup: true, 
    },
    headerFilterPlaceholder: "Wähle gewünschten Type",
  });
});
