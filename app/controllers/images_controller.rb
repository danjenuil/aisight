class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = current_user.images.new(image_params)
    if @image.save
      redirect_to @image, notice: 'Image was successfully uploaded.'
    else
      render :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_back_or_to images_path, notice: 'Image was successfully destroyed.'
  end

  private

  def image_params
    params.require(:image).permit(:title, :file)
  end
end
