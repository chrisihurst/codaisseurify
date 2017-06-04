class AlbumsController < ApplicationController
 respond_to :html, :js
def index
  @albums = Album.all.order_list(params[:sort_by])
end

def show
  @album = Album.find(params[:id])
  @artist = Artist.find(@album.artist_id)
end

def new
  @album = Album.new
end

def create
  @album = Album.new(album_params)

  if @album.save
     redirect_to @album
  else
     render 'new'
  end
end

def edit
  @album = Album.find(params[:id])
end

def update
  @album = Album.find( params[:id] )

  if @album.update_attributes( album_params )
     redirect_to @album
  else
     render 'edit'
  end
end


def destroy
  @album = Album.find(params[:id])
  @album.destroy!

  respond_to do |format|
    format.html { redirect_to albums_url }
    format.json { head :no_content }
    format.js   { render :layout => false }
  end
end

private

def album_params
  params.require(:album).permit(:album_name, :released, :album_image_url, :artist_id)
end
end
