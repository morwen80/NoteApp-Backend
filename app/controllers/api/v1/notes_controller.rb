class Api::V1::NotesController < ApplicationController
  before_action :find_note, only: [:update]

# rendering all notes in the form of JSON.
  def index
    @notes = Note.all
    render json: @notes
    end

# We're creating a new note based on whatever note_params we get from our frontend.
  def update
    @note.update(note_params)
    if @note.save
      render json: @note, status: :accepted
    else
      render json: {errors: @note.errors.full_messages}, status: :unprocessible_entity
    end
  end

  private

# We're setting out note_params to permit a parameter named title and a parameter
# named content. These must be included in the body of the POST or PATCH requests
# we will be making with JS fetch.
  def note_params
    params.permit(:title, :content)
  end

  def find_note
    @note = Note.find(params[:id])
  end

end
