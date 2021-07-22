require_relative 'utility_module'
require_relative 'account_module'

bank_object_count = 0
$account_numbers = []
$bank_ids = []
$bank_ids_hash = {}
$bank_addr_hash = {}

$axis_customer_details = {}
$india_customer_details = {}


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

    def exit
       exit
    end

    def getCustomer_byid_axis
        customer_id = gets.chomp.to_s
        if not $axis_customer_details.include? customer_id
            puts "Please enter valid customer id"
            getCustomer_byid_axis
        else
            # puts $axis_customer_details[customer_id] 
            for x in $axis_customer_details[customer_id].keys 
                puts "#{x} --> #{$axis_customer_details[customer_id][x]}" 
            end    
        end       
    end
    def getCustomer_byid_india
        customer_id = gets.chomp.to_s
        if not $india_customer_details.include? customer_id
            puts "Please enter valid customer id"
            getCustomer_byid_india
        else
            # puts $india_customer_details[customer_id] 
            for x in $getCustomer_byid_india[customer_id].keys 
                puts "#{x} --> #{$getCustomer_byid_india[customer_id][x]}" 
            end 

        end       

    end
    
    def all_customer_axis
        for x in $axis_customer_details.keys
            puts "#{x} customerdetails----"
            puts "---------"
            for y in $axis_customer_details[x].keys
                puts "#{y} -->#{$axis_customer_details[x][y]}"
            end
            puts "---------"    
        end    
    end
    def all_customer_india
        for x in $india_customer_details.keys
            puts "#{x} customerdetails----"
            puts "---------"
            for y in $india_customer_details[x].keys
                puts "#{y} -->#{$india_customer_details[x][y]}"
            end
            puts "---------"    
        end    
    end


    def getIntoAxisBank
        def welcome_axis
            puts "\nwelcome to the Axis-Bank, please enter 'a' for Axis-Bank details, 'c' for Axis-Bank Customers details,
            , 'cd' for customer details by customer id, 'i' for get_into your account, 'e' for exit "
            response = gets.chomp.downcase
    
            case response 
                when "a"
                    puts "Axis Bank Details----"
                    puts "Axis-Bank-id --> #{$bank_ids_hash['AxisBank']}"
                    puts "Axis-Bank-addr --> #{$bank_addr_hash['AxisBank']}"
                when "c"
                    puts "Here is Axis Bank Customer Details ---------"
                    all_customer_axis
                when "cd"
                    puts "Please enter your customer id"  
                    getCustomer_byid_axis
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
            puts "\nwelcome to the India-Bank, please enter 'a' for India-Bank details, 'c' for India-Bank Customers details,
            , 'cd' for customer details by customer id, 'i' for get_into your account, 'e' for exit:"
            response = gets.chomp.downcase
    
            case response 
                when "a"
                    puts "India Bank Details----"
                    puts "India-Bank-id --> #{$bank_ids_hash['IndiaBank']}"
                    puts "India-Bank-addr --> #{$bank_addr_hash['IndiaBank']}"
                when "c"
                    puts "Here is India Bank Customer Details ---------"
                    all_customer_india
                when "cd"
                    puts "Please enter your customer id"  
                    getCustomer_byid_india   
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
    attr_reader :account
    def initialize(cid, cname, caddr, account)
        @cid = cid
        @cname = cname
        @caddr = caddr
        @account = account
    end 

    def custDetails
        puts "\nCustomer Details"
        puts "----------------------"
        puts "Customer ID      #{@cid}"
        puts "Customer Name    #{@cname}"
        puts "Customer Address #{@caddr}"
        @account.getAccountDetails
    end
    def getCustomerId
        @cid
    end
    def make_details
        {'customer_id': @cid, 'customer_name': @cname, 'customer_address': @caddr, 'customer_account': @account.get_accno,'customer_balance': @account.get_balance,
    "bank_id": @account.get_bankid} 
    end

end


class Account 

    attr_reader :customer, :history, :accNo
    def initialize (accHolderName, balance, bank_id)
        @accHolderName = accHolderName
        @balance = balance
        @customer = customer
        @history = [@balance]
        @accNo = Utility.generate_acc_no
        @bank_id = bank_id
    end

    def add_customer(customer_obj)
        $customers << customer_obj
    end
    
    def getAccountDetails
        puts "\nAccount Details"
        puts "----------------------"
        puts "Account Number    --  #{$account_numbers.last}"
        puts "Account Holder Name --#{@accHolderName}"
        puts "Account Balance  -- #{@balance}"
        puts "Bank Id  -- #{@bank_id}"
    end
    
    def get_accno
        @accNo
    end
    def get_balance
        @balance
    end    
    def get_bankid
        @bank_id    
    end
    def bal
        puts "your balance is #{@balance}"
    end

    def his
        puts "this is your history"
        puts history
    end

    def dep
        puts "how much would you like to deposit"
        input = ''
        input = gets.chomp.to_i
        puts "you are depositing #{input}"
        @balance += input
        @history << input
    end

    def withd
        puts "how much would you like to withdraw?"
        input  = ''
        input = gets.chomp.to_i
        if @balance < input
            error
            withd
        else
            puts "you have chosen to withdraw #{input}"
            @balance -= input
            @history << -input
        end
    end

    def exit 
        puts "Thank you"
    end

    def error
        puts "error invalid"
    end

    def clear
        system("clear")
    end

    def welcome
        puts "\nwelcome to the bank, please enter 'b' for balance, 'h' for history, 'w' for withdrawn, 'd', 'c' for continue for deposit 'e' for exit:"
        response = gets.chomp.downcase

        case response 
            when "b"
                bal
                welcome
            when "w"
                withd
                welcome
            when "e"
                exit
            when "h"
                his
                welcome
            when "d"
                dep
                welcome
            when "d"
                cont    
            else
                clear
            end
    end    

    def cont
        welcome
    end  
end




axisbank = AxixBank.new("Gwl")
bank_object_count +=1
$bank_ids_hash['AxisBank'] = axisbank.getbankid[bank_object_count-1]
$bank_addr_hash['AxisBank'] = axisbank.getbankaddr

indiabank = IndiaBank.new("Indore")
bank_object_count +=1
$bank_ids_hash['IndiaBank'] = indiabank.getbankid[bank_object_count-1]
$bank_addr_hash['IndiaBank'] = indiabank.getbankaddr

acc1 = Account.new("Mukul", 10000, $bank_ids_hash['AxisBank'])
cust1 = Customers.new("C-101", "Mukul", "Indore", acc1)
# customer_object_count += 1
$cust_details[cust1.getCustomerId] = cust1.make_details
$axis_customer_details[cust1.getCustomerId] = cust1.make_details

# puts $axis_customer_details
# cust1.custDetails

acc2 = Account.new("Mukul", 10000, $bank_ids_hash['AxisBank'])
cust2 = Customers.new("C-102", "Prav", "Gwl", acc2)
# customer_object_count += 1
$cust_details[cust2.getCustomerId] = cust2.make_details
$axis_customer_details[cust2.getCustomerId] = cust2.make_details

acc3 = Account.new("Mukul", 10000, $bank_ids_hash['AxisBank'])
cust3 = Customers.new("C-103", "Raj", "Banglore", acc3)
$axis_customer_details[cust3.getCustomerId] = cust3.make_details


# customer_object_count += 1
$cust_details[cust3.getCustomerId] = cust3.make_details

acc4 = Account.new("Mukul", 10000, $bank_ids_hash['IndiaBank'])
cust4 = Customers.new("C-104", "Aman", "Noida", acc4)

# customer_object_count += 1
$cust_details[cust4.getCustomerId] = cust4.make_details
$india_customer_details[cust4.getCustomerId] = cust4.make_details


acc5 = Account.new("Mukul", 10000, $bank_ids_hash['IndiaBank'])
cust5 = Customers.new("C-105", "Rohan", "Gurugram", acc5)

# customer_object_count += 1
$cust_details[cust5.getCustomerId] = cust5.make_details
$india_customer_details[cust5.getCustomerId] = cust5.make_details


acc6 = Account.new("Mukul", 10000, $bank_ids_hash['IndiaBank'])
cust6 = Customers.new("C-106", "Kapil", "Delhi", acc6)

# customer_object_count += 1
$cust_details[cust6.getCustomerId] = cust6.make_details
$india_customer_details[cust6.getCustomerId] = cust6.make_details

bank = Bank.new
bank.welcome


# # puts $axis_customer_details
# puts $india_customer_details

# puts $cust_details






# puts $bank_ids_hash
# puts $cust_details