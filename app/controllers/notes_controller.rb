class NotesController < ApplicationController

  before_action :authenticate_mod!

  def destroy
    note = Note.find_by(id: params[:id])
    if note.present? && note.destroy
      set_flash_message(:success, 'Note Deleted')
    else
      set_flash_message(:error, "Cannot Find Note (ID: #{params[:id]}")
    end
    redirect_back fallback_location: root_path
  end
end
