import React from 'react';
import CreatableSelect from "react-select/creatable";

function CreatableSelectComponent({modelName, fieldName, options}) {  

  return (
          <CreatableSelect
            className={`${fieldName}-select`}
            name={`${modelName}[${fieldName}]`}
            options={options}
            autoFocus
            placeholder={fieldName}
            noOptionsMessage="Not found..."
          />
  );
}

export default CreatableSelectComponent;