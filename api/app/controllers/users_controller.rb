class UsersController < ApplicationController
    
    def show
        @name = 'sandra'
        #@ => instansvariable => finns i vyn
        #@user = User.where(...)
        #render '/_user' #vyn (annars users/show.json.jbuilder)
    end

end