require_relative 'utility_module'
require_relative 'account_module'

bank_object_count = 0
$bank_ids_hash = {}
$bank_addr_hash = {}

class Bank
    def welcome
        puts "\nwelcome to the Bank Management System, please enter 'a' for Axis-Bank details, 'i' for India-Bank details,'e' for exit:"
        response = gets.chomp.downcase

        case response 
            when "a"
                puts "Wecome to Axis Bank"
                getIntoAxisBank
            when "i"
                puts "Wecome to India Bank"
                getIntoIndiaBank
            when "e"
                puts 'Exit'
            else
                puts "Invalid input"
                welcome
            end
    end
    def getIntoAxisBank
        def welcome_axis
            puts "\nwelcome to the Axis-Bank, please enter 'a' for Axis-Bank details, 'c' for Axis-Bank Customers details,'e' for exit:"
            response = gets.chomp.downcase
    
            case response 
                when "a"
                    puts "Axis Bank Details----"
                    puts "Axis-Bank-id --> #{$bank_ids_hash['AxisBank']}"
                    puts "Axis-Bank-addr --> #{$bank_addr_hash['AxisBank']}"
                when "c"
                    puts "Here is Axis Bank Customer Details ---------"
                when "e"
                    puts 'Exit'
                else
                    puts "Invalid input"
                    welcome_axis
                end
        end
        welcome_axis
    end
    def getIntoIndiaBank
        def welcome_india
            puts "\nwelcome to the India-Bank, please enter 'a' for India-Bank details, 'c' for India-Bank Customers details,'e' for exit:"
            response = gets.chomp.downcase
    
            case response 
                when "a"
                    puts "India Bank Details----"
                    puts "India-Bank-id --> #{$bank_ids_hash['IndiaBank']}"
                    puts "India-Bank-addr --> #{$bank_addr_hash['IndiaBank']}"
                when "c"
                    puts "Here is India Bank Customer Details ---------"
                when "e"
                    puts 'Exit'
                else
                    puts "Invalid input"
                    welcome_india
                end
        end
        welcome_india 
    end
    

end



class AxixBank 
    attr_reader :bank_id
     
     def initialize(b_addr)
        @bank_addr = b_addr
        @bank_id = Utility.generate_bank_id
     end
    def getbankid
       @bank_id
    end
    def getbankaddr
        @bank_addr
     end
end  
class IndiaBank 
    attr_reader :bank_id
     
     def initialize(b_addr)
        @bank_addr = b_addr
        @bank_id = Utility.generate_bank_id
     end
    def getbankid
       @bank_id
    end
    def getbankaddr
        @bank_addr
    end
end     




class Customers
    attr_reader :cid
    def initialize(cname, caddr)
        @cid = Utility.generate_cust_id
        @cname = cname
        @caddr = caddr
        # @account = account
    end 

    def custDetails
        puts "\nCustomer Details"
        puts "----------------------"
        puts "Customer ID      #{@cid}"
        puts "Customer Name    #{@cname}"
        puts "Customer Address #{@caddr}"
        # @account.getAccountDetails
    end
    def getCustomerId
        @cid
    end

end

axisbank = AxixBank.new("Gwl")
bank_object_count +=1
$bank_ids_hash['AxisBank'] = axisbank.getbankid[bank_object_count-1]
$bank_addr_hash['AxisBank'] = axisbank.getbankaddr

indiabank = IndiaBank.new("Gwl")
bank_object_count +=1
$bank_ids_hash['IndiaBank'] = indiabank.getbankid[bank_object_count-1]
$bank_addr_hash['IndiaBank'] = indiabank.getbankaddr

bank = Bank.new
bank.welcome

# puts $bank_ids_hash