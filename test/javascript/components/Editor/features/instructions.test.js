jest.mock('../../../../../app/javascript/components/editor/FileEditorAce')

import React from 'react'
import { render, screen, waitFor } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'
import { Editor } from '../../../../../app/javascript/components/Editor'

test('displays introduction', async () => {
  render(
    <Editor
      files={[{ filename: 'lasagna.rb', content: 'class Lasagna' }]}
      introduction="Ruby is a nice and concise language"
      assignment={{
        overview: '',
        generalHints: [],
        tasks: [],
      }}
    />
  )

  expect(
    await screen.findByText('Ruby is a nice and concise language')
  ).toBeInTheDocument()
})

test('does not display introduction if not specified', async () => {
  render(
    <Editor
      files={[{ filename: 'lasagna.rb', content: 'class Lasagna' }]}
      introduction=""
      assignment={{
        overview: '',
        generalHints: [],
        tasks: [],
      }}
    />
  )

  await waitFor(() =>
    expect(screen.queryByText('Introduction')).not.toBeInTheDocument()
  )
})

test('displays introductions overview', async () => {
  render(
    <Editor
      files={[{ filename: 'lasagna.rb', content: 'class Lasagna' }]}
      assignment={{
        overview: 'There are a couple of tasks to work on',
        generalHints: [],
        tasks: [],
      }}
    />
  )

  expect(
    await screen.findByText('There are a couple of tasks to work on')
  ).toBeInTheDocument()
})

test('displays debugging information', async () => {
  render(
    <Editor
      files={[{ filename: 'lasagna.rb', content: 'class Lasagna' }]}
      debuggingInstructions="To debug, print to the console"
      assignment={{
        overview: '',
        generalHints: [],
        tasks: [],
      }}
    />
  )

  expect(
    await screen.findByText('To debug, print to the console')
  ).toBeInTheDocument()
})
