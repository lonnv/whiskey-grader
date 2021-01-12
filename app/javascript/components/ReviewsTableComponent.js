import React from "react";
import { useTable, usePagination, useGlobalFilter } from "react-table";

import { GlobalFilter, Pagination, ResultSummary } from "./reviews_table";

function Table({
  columns,
  data,
  fetchData,
  loading,
  reviewsCount,
  pageCount: controlledPageCount,
}) {
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    prepareRow,
    page,
    canPreviousPage,
    canNextPage,
    pageOptions,
    gotoPage,
    nextPage,
    previousPage,
    setPageSize,
    preGlobalFilteredRows,
    setGlobalFilter,
    pageCount,
    state: { pageIndex, pageSize, globalFilter },
  } = useTable(
    {
      columns,
      data,
      initialState: { pageIndex: 0, pageSize: 20 },
      manualPagination: true,
      manualGlobalFilter: true,
      pageCount: controlledPageCount,
    },
    useGlobalFilter,
    usePagination
  );

  // Listen for changes in pagination and filters and use the state to fetch our new data
  React.useEffect(() => {
    fetchData({ pageIndex, pageSize, globalFilter });
  }, [fetchData, pageIndex, pageSize, globalFilter]);

  return (
    <div className="container">
      <div className="d-flex flex-row justify-content-between search-row">
        <div>
          <GlobalFilter
            preGlobalFilteredRows={preGlobalFilteredRows}
            globalFilter={globalFilter}
            setGlobalFilter={setGlobalFilter}
          />
        </div>
        <div>
          <ResultSummary
            loading={loading}
            pageCount={page.length}
            totalCount={reviewsCount}
          />
        </div>
      </div>

      <table className="table table-hover" {...getTableProps()}>
        <thead>
          {headerGroups.map((headerGroup) => (
            <tr {...headerGroup.getHeaderGroupProps()}>
              {headerGroup.headers.map((column) => (
                <th scope="col" {...column.getHeaderProps()}>
                  {column.render("Header")}
                </th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody {...getTableBodyProps()}>
          {page.map((row, i) => {
            prepareRow(row);
            return (
              <tr {...row.getRowProps()}>
                {row.cells.map((cell) => {
                  return (
                    <td {...cell.getCellProps()}>{cell.render("Cell")}</td>
                  );
                })}
              </tr>
            );
          })}
        </tbody>
      </table>

      <Pagination
        canPreviousPage={canPreviousPage}
        canNextPage={canNextPage}
        pageOptions={pageOptions}
        gotoPage={gotoPage}
        nextPage={nextPage}
        previousPage={previousPage}
        pageIndex={pageIndex}
        pageCount={controlledPageCount}
      />
    </div>
  );
}

function ReviewsTableComponent({ fetchUrl }) {
  const columns = React.useMemo(
    () => [
      {
        Header: "Title",
        accessor: "title",
      },
      {
        Header: "Avg grade",
        accessor: "average_grade",
      },
      {
        Header: "Taste",
        accessor: "taste_grade",
      },
      {
        Header: "Color",
        accessor: "color_grade",
      },
      {
        Header: "Smokiness",
        accessor: "smokiness_grade",
      },
    ],
    []
  );

  const [data, setData] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [reviewsCount, setReviewsCount] = React.useState(0);
  const [pageCount, setPageCount] = React.useState(0);

  const fetchIdRef = React.useRef(0);

  const fetchData = React.useCallback(
    ({ pageSize, pageIndex, globalFilter }) => {
      const fetchId = ++fetchIdRef.current;
      setLoading(true);

      if (fetchId === fetchIdRef.current) {
        const url = new URL(fetchUrl);
        const params = {
          page: pageIndex + 1,
          page_size: pageSize,
          filter: globalFilter,
        };
        url.search = new URLSearchParams(params).toString();

        fetch(url)
          .then((response) => response.json())
          .then((body) => {
            const serverData = body.entries;
            setData(serverData);
            setReviewsCount(body.total_entries);
            setPageCount(Math.ceil(body.total_entries / body.per_page));
            setLoading(false);
          });
      }
    },
    []
  );

  return (
    <Table
      columns={columns}
      data={data}
      fetchData={fetchData}
      loading={loading}
      reviewsCount={reviewsCount}
      pageCount={pageCount}
    />
  );
}

export default ReviewsTableComponent;
