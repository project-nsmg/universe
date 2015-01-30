require 'rubygems'
require 'sinatra'
require 'mongo'
require 'json'
require 'erb'
require 'cloudinary'

$: << './server'

require 'model'

require 'pp'

configure do
  set :public_folder, 'static'
  GALLERY=ERB.new(File.read('static/gallery.html'))
  $glsl=GlslDatabase.new
  EFFECTS_PER_PAGE=50
end

get '/' do
  if(params[:page])
    page=params[:page].to_i
  else
    page=0
  end
  ef=$glsl.get_page(page, EFFECTS_PER_PAGE)
  GALLERY.result(ef.bind)
end

get '/edit' do
  send_file 'static/edit.html'
end

post '/edit' do
  body=request.body.read
  $glsl.save_effect(body)
end

get %r{/item/(\d+)([/.](\d+))?} do
  code_id=params[:captures][0].to_i
  if params[:captures][1]
    version_id=params[:captures][2].to_i
  else
    version_id=nil
  end

  $glsl.get_code_json(code_id, version_id)
end

get '/diff' do
  send_file 'static/diff.html'
end

get %r{^/(\d+)(/(\d+))?$} do
  url="/e##{params[:captures][0]}"
  url+=".#{params[:captures][2]}" if params[:captures][1]
  redirect url, 301
end
