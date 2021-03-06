class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.find_or_create_by(name: params[:Name], artist: Artist.find_or_create_by(name: params["Artist Name"]))
    @song.genre_ids = params[:genres]
    @song.save
    erb :'songs/show', locals: {message: "Successfully created song."}
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end

  put '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.name = params[:Name]
    @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    erb :'songs/show', locals: {message: "Song successfully updated."}
  end

end