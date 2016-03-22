require_relative '../lib/all'

def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end

# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[2]
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    @request = parse(raw_request)
    @params  = @request[:params]
    # Use the @request and @params ivars to full the request and
    # return an appropriate response

    # YOUR CODE GOES BELOW HERE

    USERS = [ {:first_name => "Jared",      :last_name => "Powers",    :age => "25"},
              {:first_name => "Jose",       :last_name => "Alvares",   :age => "28"},
              {:first_name => "Jeff",       :last_name => "Green",     :age => "29"},
              {:first_name => "Curt",       :last_name => "Schilling", :age => "33"},
              {:first_name => "Dave",       :last_name => "Harris",    :age => "17"},
              {:first_name => "Hugh",       :last_name => "Jackson",   :age => "55"},
              {:first_name => "Encinio",    :last_name => "Varela",    :age => "73"},
              {:first_name => "Daniel",     :last_name => "Vargas",    :age => "22"},
              {:first_name => "Sebastian",  :last_name => "Vargas",    :age => "27"},
              {:first_name => "Nathan",     :last_name => "Price",     :age => "29"},
              {:first_name => "Tyson",      :last_name => "Chandler",  :age => "21"},
              {:first_name => "Jared",      :last_name => "Allen",     :age => "23"},
              {:first_name => "Anita",      :last_name => "Hebert",    :age => "25"},
              {:first_name => "Josh",       :last_name => "Smith",     :age => "27"},
              {:first_name => "Walter",     :last_name => "Sandino",   :age => "34"},
              {:first_name => "Bear",       :last_name => "Prince",    :age => "23"},
              {:first_name => "Peter",      :last_name => "Samson",    :age => "26"},
              {:first_name => "Tom",        :last_name => "Brady",     :age => "44"},
              {:first_name => "John",       :last_name => "Doe",       :age => "33"},
              {:first_name => "Shelly",     :last_name => "Smith",     :age => "19"},
    ]

    if @params[:id] == nil
      USERS.each do |hash|
        puts "HTTP/1.1 200"
        puts hash.values.join(" ")
      end
    elsif @params[:id].to_i > USERS.length
      puts "HTTP/1.1 404"
      puts "Name not found"
    elsif id = @params[:id].to_i-1
      puts "HTTP/1.1 200"
      puts USERS[id].values.join(" ")
    # else
    #   puts "Not a valid HTTP address"
    end



    # puts @request.inspect
    # YOUR CODE GOES ABOVE HERE  ^
  end
end
