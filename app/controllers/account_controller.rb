class AccountController < ApplicationController
  def login
  end

  def authenticate
    username = params[:username]
    user = Account.where(name: username).take
    if (user==nil)
      @error=true
      @message='No such user'
      render 'login'
      return
    end
    require 'digest'
    password = params[:password]
    salt = user.salt
    hash = Digest::SHA256.digest(salt + password).force_encoding('UTF-8')
    if (hash == user.pass_hash)
      session[:userId] = user.id
      session[:power] = user.usergroup
      @username=user.name
      @error=false
    else
      @error=true
      @message="Wrong password"
      render 'login'
      return
    end
  end

  def new

  end
  def create
    username = params[:username]
    user = Account.where(name: username).take
    if (user != nil)
      @error=true
      @message='User already exists'
      render 'new'
      return
    end
    require 'digest'
    password = params[:password]
    salt = (0...8).map { (1 + rand(254)).chr }.join.force_encoding('UTF-8')
    hash = Digest::SHA256.digest(salt + password).force_encoding('UTF-8')
    user = Account.create(
      name: username,
      pass_hash: hash,
      salt: salt,
      usergroup: 2
    )
    session[:userId] = user.id
    session[:power] = user.usergroup
    @username=user.name
  end
end
