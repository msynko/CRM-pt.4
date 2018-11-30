require_relative 'contact'
require 'sinatra'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  @title = "About"
  erb :index
end

get '/about' do
 redirect to ('/')
end

get '/contacts/new' do
  @title = 'Add New Contact'
  erb :new
end

get '/contacts/:id' do
    @contact = Contact.find_by(id: params[:id].to_i)
    if @contact
      erb :show_contacts
    else
      raise Sinatra::NotFound
    end
end

get '/contacts' do
  @contacts = Contact.all
  erb :contacts
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  @title = "Edit a Contact"
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.find_by(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end
