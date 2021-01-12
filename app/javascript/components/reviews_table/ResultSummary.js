import React from 'react';

function ResultSummary({ loading, pageCount, totalCount }) {
  return (
    <span>
      {loading ? (
        'Loading...'
      ) : (
          `Showing ${pageCount} of ~${totalCount} results`
      )}
    </span>
  );
}

export default ResultSummary;