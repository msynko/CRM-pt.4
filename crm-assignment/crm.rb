require "./contact.rb"

class CRM

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end


  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
      # Finish off the rest for 3 through 6
      # To be clear, the methods add_new_contact and modify_existing_contact
      # haven't been implemented yet
    end
  end

  def add_new_contact
    puts "Enter first name:"
    first_name = gets.chomp
    puts "Enter last name:"
    last_name = gets.chomp
    puts "Enter email:"
    email = gets.chomp
    puts "Enter note:"
    note = gets.chomp
    contact = Contact.create(first_name:first_name,
      last_name:last_name, email: email, note: note)
    puts "-------------"
    puts "#{first_name} #{last_name} added."
    puts "-------------"

    return contact
  end

  def get_id
    puts "Enter the id of the contact you wish to modify:"
    user_id = gets.chomp.to_i
    return user_id
  end

  def print_modify_menu
    puts "Enter the attribute you wish to modify"
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email"
    puts "[4] Note"
  end

  def call_modify_option(user_selected, id)
    case user_selected
      when 1 then change_first_name(id)
      when 2 then change_last_name(id)
      when 3 then change_email(id)
      when 4 then change_note(id)
    end
  end


  def change_first_name(id)
    puts "Current first name: #{Contact.find(id).first_name}"
    value = get_modify_value
    Contact.find(id).first_name=(value)
  end

  def change_last_name(id)
    puts "Current last name: #{Contact.find(id).last_name}"
    value = get_modify_value
    Contact.find(id).last_name=(value)
  end

  def change_email(id)
    puts "Current email: #{Contact.find(id).email}"
    value = get_modify_value
    Contact.find(id).email=(value)
  end

  def change_note(id)
    puts "Current note name: #{Contact.find(id).note}"
    value = get_modify_value
    Contact.find(id).note=(value)
  end

  def get_modify_value
    puts "Enter the new value:"
    value = gets.chomp
    return value
  end


  def modify_existing_contact
    id = get_id
    puts "-------------"
    puts "#{Contact.find(id).first_name} #{Contact.find(id).last_name} | #{Contact.find(id).email} | #{Contact.find(id).note}"
    puts "-------------"
    print_modify_menu
    user_selected = gets.to_i
    call_modify_option(user_selected, id)
    puts "-------------"
    puts "#{Contact.find(id).first_name} #{Contact.find(id).last_name} | #{Contact.find(id).email} | #{Contact.find(id).note}"
    puts "-------------"
  end

  def delete_contact
    id = get_id
    contact = Contact.find(id)
    contact.delete
    puts "-------------"
    puts "#{contact.first_name} #{contact.last_name} deleted."
    puts "-------------"
  end

  def display_all_contacts
    puts "-------------"
    puts "Contacts:"
    puts Contact.all
    puts "-------------"
  end

  def print_by_option_menu
    puts "Enter the attribute you wish to search by"
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email"
    puts "[4] Note"
  end

  def call_search_by_option(user_selected)
    case user_selected
      when 1 then
        puts "-------------"
        puts "First name"
        puts "-------------"
        show_search_results("first_name")
      when 2 then
        puts "-------------"
        puts "First name"
        puts "-------------"
        show_search_results("last_name")
      when 3 then
        puts "-------------"
        puts "First name"
        puts "-------------"
        show_search_results("email")
      when 4 then
        puts "-------------"
        puts "First name"
        puts "-------------"
        show_search_results("note")
    end
  end

  def get_search_value
    puts "Enter the value to search by:"
    value = gets.chomp
    return value
  end

  def show_search_results(attribute)
    value = get_search_value
    puts "-------------"
    puts "Results:"
    puts Contact.find_by(attribute, value)
    puts "-------------"

  end

  def search_by_attribute
    print_by_option_menu
    user_selected = gets.to_i
    call_search_by_option(user_selected)

  end

  at_exit do
    ActiveRecord::Base.connection.close
  end

end

 crm = CRM.new
 crm.main_menu
