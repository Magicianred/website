import React from 'react'
import pluralize from 'pluralize'
import { Track } from '../TrackSelector'
import { Icon, TrackIcon } from '../../common'

export const TrackCheckbox = ({
  id,
  title,
  iconUrl,
  avgWaitTime,
  numSolutionsQueued,
  checked,
  onChange,
}: Track & {
  checked: boolean
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void
}): JSX.Element => {
  return (
    <div className="track">
      <input
        type="checkbox"
        id={id}
        checked={checked}
        onChange={onChange}
        aria-labelledby={`${id}-label`}
      />
      <label className="track" htmlFor={id} id={`${id}-label`}>
        {checked ? (
          <div className="selected-icon">
            <Icon icon="checkmark" alt="Track selected" />
          </div>
        ) : null}
        <TrackIcon iconUrl={iconUrl} title={title} />
        <div className="title">{title}</div>
        <div className="info">
          Avg. wait time ~ {avgWaitTime}
          <br />
          {numSolutionsQueued} {pluralize('solution', numSolutionsQueued)}{' '}
          queued
        </div>
      </label>
    </div>
  )
}
