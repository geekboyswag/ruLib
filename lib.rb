require "socket";

class Racism
	def initialize(chat, server, nigger, password)
	        @nigger = nigger;
		@password = password;
		@name = chat;
		@server = server;
		@port = 443;
		@racist_sock = nil;
		@ping_thread = Thread.new do
			loop do
				sleep(10);
				ping();
			end
		end
		@connected = false
		connect()
	end
	
	def connect()
	    @racist_sock = TCPSocket.open(@server, @port);
            bauth(@name, @nigger, @password);
	    @connected = true
	    say("Successfully connected to <b>#{@name}</b> using rulib Ver 0.3B");
	    main()
	end
	
	def ping()
	    send('\r\n\x00');
	end
	
	def send(bytes)
            @racist_sock.print bytes;
        end
	
	def main()
	    while( @connected )
		data = @racist_sock.recv(1024);
		if( data == "" || data == nil )
	           ping();
		else
	           process_data(data);
		end
	    end
	end
	
        def say(saying)
	    send("bmsg:t12r:<n000/><f x11000='0'>#{saying}\r\n\x00");
        end

        def bauth(chat, nigger, password)
    	    send("bauth:#{chat}::#{nigger}:#{password}\x00");
        end
	  
	def process_data( data )
	    data_array = data.split( ":" );
	    if( data[-1..-1] == ":" )
	       data_array << nil;
	    end
	    case( data_array[0] )
		when "b"
	             parse = data_array[9..-1].join('').gsub(/<.*?>/, '').gsub('\x00', '');
	             saying = parse.gsub("&lt;", "<").gsub("&gt;", ">").gsub("&#39;", "'").gsub("&quot;", "\"").gsub("&amp", "&");
	             if (data_array[2].length > 0)
	                 nigger = data_array[2]
	             elsif (data_array[3].length > 0)
	                 nigger = '#'+data_array[3];
	             else 
	                 nigger = '!anon'
	             end 
	             puts "[#{@name}]#{nigger}: #{saying}";
		when "ok"
	             @owner = data_array[1];
		     @fags = data_array[7].split(';');
	        when "u"
		when "inited"
		     puts "connected to #{@name}"
		when "denied"
		     puts "unable to join #{@name}"
		end
	end
end
				
