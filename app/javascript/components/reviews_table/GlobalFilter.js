import "regenerator-runtime/runtime";
import React, { useState } from "react";
import { useAsyncDebounce } from "react-table";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSearch } from "@fortawesome/free-solid-svg-icons";

function GlobalFilter({
  preGlobalFilteredRows,
  globalFilter,
  setGlobalFilter,
}) {
  const count = preGlobalFilteredRows.length;
  const [value, setValue] = useState(globalFilter);
  const onChange = useAsyncDebounce((value) => {
    setGlobalFilter(value || undefined);
  }, 200);

  return (
    <div className="input-group">
      <div className="form-outline">
        <input
          id="search-form"
          className="form-control"
          type="search"
          value={value || ""}
          onChange={(e) => {
            setValue(e.target.value);
            onChange(e.target.value);
          }}
          placeholder="Search"
        />
      </div>
      <span className="input-group-text">
        <FontAwesomeIcon icon={faSearch} />
      </span>
    </div>
  );
}

export default GlobalFilter;
