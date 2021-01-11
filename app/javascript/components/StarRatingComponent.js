import React from "react"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faStar } from '@fortawesome/free-solid-svg-icons'

const iconColor = (ratingValue, hover, rating) => {
  return (
    ratingValue <= (hover || rating)
      ? "#f3c623" // yellow
      : "#e4e5e9" // gray
  )
}

const inputName = (modelName, fieldName) => {
  return `${modelName}[${fieldName}]`
}

const StarRatingComponent = ({ modelName, fieldName, value = 0 }) => {
  const [rating, setRating] = React.useState(value)
  const [hover, setHover] = React.useState(null)

  return (
    <div id={fieldName} className='star-rating'>
      {
        [...Array(5)].map((_, i) => {
          const ratingValue = i + 1
          return (
            <label key={i} id={`${fieldName}${ratingValue}`}>
              <input
                type="radio"
                name={inputName(modelName, fieldName)}
                value={ratingValue}
                onClick={() => setRating(ratingValue)}
              />

              <FontAwesomeIcon
                icon={faStar}
                color={iconColor(ratingValue, hover, rating)}
                onMouseEnter={() => setHover(ratingValue)}
                onMouseLeave={() => setHover(null)}
              />
            </label>
          )
        })}
    </div>
  );
}

export default StarRatingComponent
