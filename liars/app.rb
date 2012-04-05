
require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Answers
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :question1, String
  property :question2, String
  property :question3, String
  property :question4, String
  property :email, String
  property :video, String
end

DataMapper.finalize

get '/' do
  form = ""
  form += <<-HTML
  <html>
    <head>
      <title>lies</title>
      <link rel="stylesheet" type="text/css" href="/~rv670/sinatra/lies/public/sinatra1.css"/>
      </head>
  HTML
  
  form += '<body>'
  form += '<form action="http://itp.nyu.edu/~rv670/sinatra/lies/results" method="POST">'
  form += '<p>This poll is about lies.  For this purpose, lying includes both direct telling of untruths as well as obscuring the actual truth in any way.</p>'
  form +='</br>'
  form += '<p>What is the biggest lie you have ever told?</br>'
  form += '<input type="text" name="question1"></p>'
  form += '<p>What is the most common lie that you tell others?</br>'
  form += '<input type="text" name="question2"></p>'
  form += '<p>Who would you say you lie to most often?</br>'
  form += '<input type="text" name="question3"></p>'
  form += '<p>What is the most common lie you tell yourself?</br>'
  form += '<input type="text" name="question4"></p>'
  form += '<br/>'
  form += '<p><strong>Info below is for follow-up purposes only!  Will not be disclosed without permission.</strong></p>'
  form += '<p><label>Name:</label> <input type="text" name="name" /></p>'
  form += '<p><label>Email:</label><input type="text" name="email" /></p></br>'
  form += '<p>Would you be interested in participating in a video interview?</p>'
  form += '<p><input type="checkbox" name="video" value="yes">Yes</p>'
  form += '<p><input type="checkbox" name="video" value="no">No</p>'

  form += '<p><input type="submit" value="submit your answer!" /></p>'
  form += '</form>'
  form += '</body>'
  form += '</html>'
  
  form

end

post '/results' do
  answers = Answers.new
  
  answers.name = params[:name]
  answers.question1 = params[:question1]
  answers.question2 = params[:question2]
  answers.question3 = params[:question3]
  answers.question4 = params[:question4]
  answers.video = params[:video]
  answers.email = params[:email]
  
  #save new values
  answers.save
  
  output = ''
  output += 'Thank you for participating!'
  
  output
end

get '/clearresults' do
  for answers in Answers.all
    answers.destroy
  end
  "deleted all answers"
end

