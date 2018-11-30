gem 'activerecord', '=4.2.10'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base

  field :first_name, as: :string
  field :last_name, as: :string
  field :email, as: :string
  field :note, as: :text

    def full_name
      "#{ first_name } #{ last_name }"
    end

end

Contact.auto_upgrade!

 betty = Contact.create(first_name:'Betty', last_name:'Maker',email:'bettymakes@gmail.com',note: 'Loves Pokemon')
 p betty.inspect



 # tom = Contact.create('Tom', 'Maker', 'tommakes@gmail.com', 'N/A')
 # puts betty.email # => 'bettymakes@gmail.com'
 # puts betty.note = 'Loves HTML & CSS'
 # p Contact.find(1)
 # puts "_____"
 # p Contact.find_by("Betty")
 # puts betty.full_name
 # puts tom.update("last_name","Tomm")
