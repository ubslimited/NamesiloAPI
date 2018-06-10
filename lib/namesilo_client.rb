require 'faraday'
require 'json'
require 'addressable'

module NamesiloClient
  class API
	    
    # Class constructor
    def initialize(apikey)
      @apikey = apikey
      @host   = 'https://www.namesilo.com/api/'
    end

    # Establish connection
    def get_connection()
      conn = Faraday.new(:url => @host) do |c|
        c.use Faraday::Request::UrlEncoded 
        c.use Faraday::Adapter::NetHttp     
      end
    end

    # Default parameters for Namesilio REST APIs
    def get_default_parameters()
      {"version":"1","type":"xml","key":@apikey}
    end

    def get_request(endpoint)
      get_connection().get endpoint
    end

    # Construct URL parameters, combing with default parameters
    def get_url_parameters(params)
      uri = Addressable::URI.new
      uri.query_values = params.merge(get_default_parameters())
      uri.query
    end

    # Return namesilo contact information
    # By default, it returns all contact informaton
    # Optional parameter: contact_id
    # e.g. get_contact_list(params={contact_id:'11111111'})
    def get_contact_list(params={})
      get_request('contactList?'+get_url_parameters(params)).body
    end

    # add a contact information
    # params is a JSON string
    # required fields:
    #   fn: First Name
    #   ln: Last Name
    #   ad: Mailing Address
    #   cy: Mailing City
    #   st: Mailing State/Province/Territory
    #   If country is US or CA, you must use the correct abbreviation
    #   zp: Mailing Zip/Postal Code
    #   ct: Mailing Country
    #   Country must use the correct abbreviation
    #   em: Email Address
    #   ph: Phone Number
    # Optional Fields
    #   nn: Nickname (24)
    #   cp: Company (64)
    #   ad2: Mailing Address 2 (128)
    #   fx: Fax (32)
    #   US Fields:
    #     usnc: .US Nexus Category (3) (must use correct abbreviation)
    #     usap: .US Application Purpose (2) (must use correct abbreviation)
    #   CA Optional Fields
    #     calf: CIRA Legal Form (correct abbreviations)
    #     caln: CIRA Language (correct abbreviations)
    #     caag: CIRA Agreement Version (correct abbreviations)
    #     cawd: CIRA WHOIS Display
    def add_contact(params)
      get_request('contactAdd?'+get_url_parameters(params)).body
    end

    # List all domains
    # Returns XML
    # xpath: /namesilo/reply/domains/domain
    def list_domains()
      get_request('listDomains?'+get_url_parameters({})).body
    end

    # Get domain info
    # Parameter: domain name
    # returns XML containing all domain info
    # xpath: /namesilo/reply
    def get_domain_info(domain)
      get_request('getDomainInfo?'+get_url_parameters({'domain':domain})).body
    end

    # List DNS records
    # Parameter: domain name
    # returns XML containing all DNS records
    # xpath: /namesilo/reply/resource_record
    def list_dns_records(domain)
      get_request('dnsListRecords?'+get_url_parameters({'domain':domain})).body
    end

    # Get a list of all active portfolios within your account.
    # returns XML containing all portfolios
    # xpath: /namesilo/reply/portfolios
    def get_portfolio_list()
      get_request('portfolioList?'+get_url_parameters({})).body
    end

    # listRegisteredNameServers
    # returns XML containing all name servers
    # xpath: /namesilo/reply/hosts
    def list_name_servers(domain)
      get_request('listRegisteredNameServers?'+get_url_parameters({'domain':domain})).body
    end

    # listEmailForwards
    # returns all email forwards
    # xpath: /namesilo/reply/addresses
    def list_email_forwards(domain)
      get_request('listEmailForwards?'+get_url_parameters({'domain':domain})).body
    end

    # registrantVerificationStatus
    # Shows the verification status for any Registrant email addresses
    # xpath: /namesilo/reply/email
    def get_registrant_verification_status()
      get_request('registrantVerificationStatus?'+get_url_parameters({})).body
    end

    # getAccountBalance
    # returns current account funds balance.
    # xpath: /namesilo/reply
    def get_account_balance()
      get_request('getAccountBalance?'+get_url_parameters({})).body
    end

    # getPrices
    # returns price list
    # xpath: /namesilo/reply
    def get_prices()
      get_request('getPrices?'+get_url_parameters({})).body
    end

    # listOrders
    # Returns Complete Account Order History
    # xpath: /namesilo/reply/order
    def list_orders()
      get_request('listOrders?'+get_url_parameters({})).body
    end

    # orderDetails
    # returns details for provided order number
    # xpath: /namesilo/reply
    def order_details(order_number)
      get_request('orderDetails?'+get_url_parameters({'order_number':order_number})).body
    end

    

  end
end
