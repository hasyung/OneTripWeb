class Clogger
	private
	def self.log(msg, br = true)
		if br
			puts msg
		else
			print msg
		end
	end

	public
	def self.info(msg, br = true)
		msg = " #{msg}"
		log(msg, br)
	end

	def self.success(msg, br = true)
		msg = "\033[42;37;1m #{msg} \033[0m"
		log(msg, br)
	end

	def self.wrarring(msg, br = true)
		msg = "\033[43;37;5m] \033[0m #{msg}"
		log(msg, br)
	end

	def self.error(msg, br = true)
		msg = "\033[41;37;5m] \033[0m #{msg}"
		log(msg, br)
	end
end