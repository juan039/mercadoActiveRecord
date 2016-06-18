require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'pry'
require './models/usuario.rb'
require './models/item.rb'


get '/' do
  redirect '/usuarios'
end

#Indice de usuarios
get '/usuarios' do
	@usuarios=Usuario.all
	erb :index 
end

#Vista de crear un nuevo usuario
get '/usuarios/new' do
	erb :new
end

#Crea un nuevo usuario
post '/usuarios' do
	Usuario.create ({nombre: params[:nombre]})
	redirect to ("/")
end

#Vista de Usuario y sus respectivos Items
get '/usuarios/:id' do
	@usuario=Usuario.find(params[:id])
	@items=@usuario.items
	erb :show	
end

#Crea un nuevo item dentro de dicho usuario, redireje a la Vista de Usuario
post '/usuarios/:id' do
	@usuario=Usuario.find(params[:id])
	@usuario.items.create({nombre: params[:nombre],precio: params[:precio]})
	redirect '/usuarios/'+params[:id]
end

#Borrar un item existente dentro de dicho usuarui
get '/usuarios/:id/delete' do
	@usuario=Usuario.find(params[:id])
	item=Item.find()
	@usuario.items.delete()
end
#La vista para agregar un item nuevo a un Usuario
get '/usuarios/:id/new' do
	@usuario=Usuario.find(params[:id])
	# @items=@usuario.items
	erb :new_item
end

#Vista para editar Usuario
get '/usuarios/:id/edit' do
	@usuario=Usuario.find(params[:id])
	erb :edit
end

#Actualizar Usuario
put '/usuarios/:id' do
	usuario = Usuario.find(params[:id])
	binding.pry
	usuario.nombre=params[:nombre]
	usuario.save
	redirect '/usuarios/'+params[:id]
end

#Borrar Usuario
delete '/usuarios/:id' do
	usuario = Usuario.find(params[:id])
	usuario.destroy
	redirect '/'
end

delete '/items/:id' do
	item=Item.find(params[:id])
	usuario=item.usuario_id
	item.destroy
	redirect '/usuarios/'+usuario
end