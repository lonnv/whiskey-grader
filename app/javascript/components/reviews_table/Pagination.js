import React from "react";

function Pagination({
  canNextPage,
  canPreviousPage,
  gotoPage,
  nextPage,
  previousPage,
  pageIndex,
  pageCount,
}) {
  return (
    <div className="d-flex flex-row justify-content-between">
      <div className=" btn-group" role="group">
        <button
          className="btn btn-light btn-sm"
          onClick={() => gotoPage(0)}
          disabled={!canPreviousPage}
        >
          {"<<"}
        </button>
        <button
          className="btn btn-light btn-sm"
          onClick={() => previousPage()}
          disabled={!canPreviousPage}
        >
          {"<"}
        </button>
        <button
          className="btn btn-light btn-sm"
          onClick={() => nextPage()}
          disabled={!canNextPage}
        >
          {">"}
        </button>
        <button
          className="btn btn-light btn-sm"
          onClick={() => gotoPage(pageCount - 1)}
          disabled={!canNextPage}
        >
          {">>"}
        </button>
        </div>
        <div>
        <span>
          Page{" "}
          <strong>
            {pageIndex + 1} of {pageCount}
          </strong>
        </span>

        </div>
      </div>
  );
}

export default Pagination;
