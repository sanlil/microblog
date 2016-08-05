class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

##
# sandra kladdar
##
# $ rails s (starta server)
# $ rails c (starta ruby consol)
# $ u = User.new(....)
# $ puts u.pretty_inspect (printa fint)
# $ u.save (kunna visa på webbsidan)
# $ u.destoy (ta bort u från databas)
# $ User.destroy_all (rensa User-tabell)
