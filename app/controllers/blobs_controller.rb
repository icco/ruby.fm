class BlobsController < ApplicationController
  def new
    @blob = Blob.new
  end

  def index
    @blobs = Blob.all
  end

  def show
    @blob = Blob.find(params[:id])
  end

  def create
    @blob = Blob.new(blob_params)

    if @blob.save
      redirect_to @blob, notice: 'Blob was successfully created.'
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def blob_params
    params.require(:blob).permit(:location)
  end
end
